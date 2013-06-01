class ScreencastShowScreen < ProMotion::Screen
  attr_accessor :id, :name

  def on_load
    @screencast = RailsCastVideo.where(:id).eq(self.id).first
    set_nav_bar_left_button "Back", action: :go_back, type: UIBarButtonItemStylePlain
    set_nav_bar_right_button "Watch", action: :open_video, type: UIBarButtonItemStylePlain

    self.navigationItem.title = @screencast.name
  end

  def will_appear
    self.view.backgroundColor = UIColor.whiteColor
    @label = add UILabel.new, {
        text: @screencast.description,
        font: UIFont.systemFontOfSize(18),
        resize: [:left, :right, :top, :bottom, :width, :height], # autoresizingMask
        left: 5, # These four attributes are used with CGRectMake
        top: 5,
        width: bounds.size.width,
        height: 20
    }
    @label.numberOfLines = 0
    @label.sizeToFit
  end

  def open_video
    BW::Media.play_modal @screencast.video_url
  end

  def go_back
    close
  end
end