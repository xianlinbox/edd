module ModelFactory
  def create_URL_dependency(params)
    group = Group.get(params[:group_id])
    url_dependency = UrlDependency.create(:name => params[:monitor_title],
                                          :description => params[:monitor_description],
                                          :url => params[:url_monitor_url]
    )
    group.url_dependencies << url_dependency
    if !group.save
      group.errors.each do |e|
        puts e
      end
    end
  end
end