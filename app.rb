require 'sinatra'

get '/' do
  "Home page"
end

get '/clima/:ciudad' do
  "Hello #{params[:ciudad]}"
end


post '/login' do
	if params[:name] == 'admin' && params[:password] == 'admin'
	  session['user_name'] = params[:name]
	else
	  redirect '/login'
	end
end

get '/login' do
  haml :login
end

before '/admin' do
    unless session['user_name']
      halt "Access denied, please <a href='/login'>login</a>."
    end
end



__END__

@@ login
%h1 login.

