class AppDelegate < ProMotion::Delegate
  def on_load(app, options)
    get_videos do
      @all_videos = AllVideoScreen.new nav_bar: true
      @recent_videos = RecentVideoScreen.new nav_bar: true
      open_tab_bar @recent_videos, @all_videos
    end
  end

  private
  def get_videos(&block)
    BW::HTTP.get('http://railscasts.com/episodes.json') do |response|
      if response.ok?
        res = BW::JSON.parse response.body
        res.each { |sc| RailsCastVideo.create sc }
      end
      block.call
    end
  end
end
