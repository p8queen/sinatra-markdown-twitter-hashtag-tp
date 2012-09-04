require 'sinatra'

enable :sessions

get '/' do
  "Home page"
end

get '/clima/:ciudad' do
  "Hello #{params[:ciudad]}"
end

get '/time/:ciudad' do
   @t = Time.now
   @city = params[:ciudad]	
   haml :time
  
end

post '/login' do
	if params[:name] == 'admin' && params[:password] == 'admin'
	  session['user_name'] = params[:name]
	  redirect '/admin'
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

get '/admin' do
  "Welcome Admin"
end


__END__

@@ login
%h1 login
%form{ :action => "/login", :method => "post"}
  %fieldset
    %ol
      %li
        %label{:for => "name"} Name:
        %input{:type => "text", :name => "name", :class => "text"}
      %li
        %label{:for => "password"} password:
        %input{:type => "text", :name => "password", :class => "text"}
      %input{:type => "submit", :value => "Login", :class => "button"}

@@ time
%p
	Hora en #{@city}: #{@t.strftime("%T")}
%p
	Hora en UTC: #{@t.utc}


