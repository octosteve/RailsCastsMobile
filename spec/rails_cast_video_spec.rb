describe RailsCastVideo do
  before do
    @episode = {"id" => 474,
               "url" => "http://railscasts.com/episodes/115-model-caching-revised.json",
               "name" => "Model Caching (revised)",
               "position" => 115,
               "permalink" => "model-caching-revised",
               "description" => "Caching at a low level is a great option when the view is too dynamic to cache and you need something flexible that can work anywhere in the application. Here I show a variety of ways to use Rails.cache with Active Record.",
               "published_at" => "2013-05-13T00:00:00-07:00",
               "comments_count" => 24,
               "duration" => "12:28",
               "file_sizes" => {
                   "zip" => "69055",
                   "mp4" => "29764021",
                   "m4v" => "15301047",
                   "webm" => "18701002",
                   "ogv" => "36761262"
               }, "pro" => true,
               "revised" => true,
               "custom_asset_domain" => "",
               "tags" => [
                   {"tag" => {"created_at" => "2008-07-25T22:22:34-07:00", "id" => 1, "name" => "performance", "updated_at" => "2008-07-25T22:22:34-07:00"}},
                   {"tag" => {"created_at" => "2008-07-25T22:22:34-07:00", "id" => 2, "name" => "active-record", "updated_at" => "2008-07-25T22:22:34-07:00"}}
               ]}

  end

  after do
    RailsCastVideo.delete_all
  end

  it "adds a record to the devices local storage" do
    rcv.name.should.equal 'Model Caching (revised)'
    rcv.description.should.equal 'Caching at a low level is a great option when the view is too dynamic to cache and you need something flexible that can work anywhere in the application. Here I show a variety of ways to use Rails.cache with Active Record.'
    rcv.free?.should.equal false

    RailsCastVideo.count.should.equal 1
  end

  it "returns a list of recent episodes" do
    RailsCastVideo.create @episode
    @episode.merge "name" => "Another Episode", "id" => 475

    RailsCastVideo.create 'name' => 'Another Episode', 'id' => 475

   RailsCastVideo.recent.map(&:name).should.equal ["Another Episode", "Model Caching (revised)"]

  end

  it "returns a video url viewable on iPhones" do
    @episode.merge('url' => 'http://railscasts.com/episodes/415-upgrading-to-rails-4.json')
    rcv = RailsCastVideo.create @episode
    rcv = RailsCastVideo.create @episode
    rcv.video_url.should.eq 'http://media.railscasts.com/assets/episodes/videos/415-upgrading-to-rails-4.m4v'

  end

end