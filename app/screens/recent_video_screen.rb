class RecentVideoScreen < ProMotion::SectionedTableScreen
  title "Recent Videos"

  def on_load
    @cells = RailsCastVideo.recent.map do |screen_cast|
      {title: screen_cast.name, action: :show_details, arguments: {id: screen_cast.id, name: screen_cast.name}}
    end
    update_table_data
  end

  def table_data
    [{ title: "", cells: @cells } ]
  end


  def show_details(args={})
    open ScreencastShowScreen.new(id: args[:id], name: args[:name])
  end

end