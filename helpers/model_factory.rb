module ModelFactory
  def create_group(params)
    error_wrapper(params) { |params|
      Group.create(:name => params[:group_name])
    }
  end

  def create_URL_dependency(params)
    error_wrapper(params) { |params|
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
    error_wrapper(params) { |params|
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

  def error_wrapper(params)
    group = yield(params)
    if !group.save
      group.errors.each do |e|
        puts e
      end
    end
  end

  def delete_group(id)
    group = Group.get(id)
    group.url_dependencies.each do |url_dependency|
      url_dependency.destroy
    end

    group.soap_dependencies.each do |soap_dependency|
      soap_dependency.destroy
    end

    if !group.destroy
      puts group.id
      puts group.url_dependencies.length
      puts group.soap_dependencies.length
      group.errors.each do |e|
        puts e
      end
    end
  end

  def get_url_dependency(id)
    UrlDependency.get(id)
  end

  def delete_url_dependency(id)
    UrlDependency.get(id).destroy
  end

  def get_soap_dependency(id)
    SoapDependency.get(id)
  end

  def delete_soap_dependency(id)
    SoapDependency.get(id).destroy
  end
end