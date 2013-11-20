module ModelFactory
  def create_group(params)
    save_group(params) { |params|
      Group.create(:name => params[:group_name])
    }
  end

  def create_URL_dependency(params)
    save_group(params) { |params|
      group = Group.get(params[:group_id])
      url_dependency = UrlDependency.create(:name => params[:monitor_title],
                                            :description => params[:monitor_description],
                                            :url => params[:url_monitor_url]
      )
      group.url_dependencies << url_dependency
      group
    }
  end

  def create_SOAP_dependency(params)
    save_group(params) { |params|
      group = Group.get(params[:group_id])
      soap_dependency = SoapDependency.create(:name => params[:monitor_title],
                                              :description => params[:monitor_description],
                                              :endpoint => params[:soap_monitor_endpoint],
                                              :username => params[:soap_monitor_username],
                                              :password => params[:soap_monitor_password],
                                              :request => params[:soap_monitor_request],
                                              :response => params[:soap_monitor_response]
      )
      group.soap_dependencies << soap_dependency
      group
    }
  end

  def save_group(params)
    group = yield(params)
    if !group.save
      group.errors.each do |e|
        puts e
      end
    end
  end
end