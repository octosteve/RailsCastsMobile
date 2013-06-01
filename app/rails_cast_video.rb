class RailsCastVideo
  include MotionModel::Model

  columns name: :string,
          full_description: :string,
          free: :integer,
          rc_id: :integer,
          video_url: :string

  def self.recent
    self.order { |first, second| second.rc_id <=> first.rc_id }.and(:free).eq(1).all[0...5]
  end

  def self.free
    self.where(:free).eq(1)
  end

  def initialize(options={})
    super
    self.name = options["name"]
    self.full_description = options["description"]
    self.free = options["pro"] ? 0 : 1
    self.rc_id = options["id"]
    self.video_url = deduce_url(options)
  end

  def deduce_url(options)
    "http://media.railscasts.com/assets/episodes/videos/#{options['position']}-#{options['permalink']}.m4v"
  end

  def description
    self.full_description
  end

  def free?
    self.pro.zero?
  end

end