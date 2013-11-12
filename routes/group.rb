# encoding: utf-8
class MyApp < Sinatra::Application
  post '/group' do
    puts params[:group_name]
    new_group = Group.create(:name => params[:group_name])
    new_group.save
    redirect '/'
  end
end
