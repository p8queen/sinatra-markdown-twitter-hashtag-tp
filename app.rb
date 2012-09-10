require 'sinatra'
require 'kramdown'
require 'open-uri'
require 'json'


enable :sessions

get '/' do
  haml :home
end

get '/clima/:ciudad' do
  "Hello #{params[:ciudad]}"
end

get '/time' do
  t = Time.now
  "Hora: #{t.strftime("%T")}, <br>hora UTC #{t.utc}"
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

get "/logout" do
  session[:user_name] = nil
  redirect "/"
end

before '/admin' do
    unless session['user_name']
      halt "Access denied, please <a href='/login'>login</a>."
    end
end

get '/admin' do
  "Welcome Admin <a href='/logout'>logout</a>."
end

get '/blog' do
  #archivos ordenados por fecha
  files = Dir.entries("docs").sort_by{|f| File.mtime("docs/#{f}")}.reverse
  haml :blog, :locals => {:files => files}
end

get '/blog/:filename' do
  haml :post, :locals => { :post => "#{params[:filename]}" }
end

get '/tweeter/?' do
  ## search hashtag
  haml :tweeter
end

get '/tweeter/search/' do
  ## search hashtag
  cantidad = 20
  res_from_tweeter = open("http://search.twitter.com/search.json?rpp=#{cantidad}&q=#{params[:hashtag]}").read
  tweets_hash = JSON.parse(res_from_tweeter) #json to hash
  ls_tweeter = tweets_hash["results"]
  haml :tweeter_hashtag, :locals => { :ls_tweeter => ls_tweeter } 
end

not_found do
  haml '%a{:href => url("/")} back to home'
end



__END__

@@ home
%h1 Home
%ol
  %li
    %a{:href => url("/blog")} blog
  %li
    %a{:href => url("/tweeter")} tweeter
  %li
    %a{:href => url("/admin")} admin
  %li
    %a{:href => url("/time")} time  

@@ login
%p
  %a{:href => url("/")} home
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

@@ tweeter
%p
  %a{:href => url("/")} home
%h1 tweeter
%form{ :action => "/tweeter/search/", :method => "get"}
  %fieldset
    %ol
      %li
        %label{:for => "hashtag"} Hashtag:
        %input{:type => "text", :name => "hashtag", :class => "text"}
      %input{:type => "submit", :value => "search", :class => "button"}

@@ tweeter_hashtag
%h1 tweeter
%form{ :action => "/tweeter/search/", :method => "get"}
  %fieldset
    %ol
      %li
        %label{:for => "hashtag"} Hashtag:
        %input{:type => "text", :name => "hashtag", :class => "text"}
      %input{:type => "submit", :value => "search", :class => "button"}
%p
  resultados:
%p
  - ls_tweeter.each do |v|
    %p
      date UTC: 
      = v["created_at"] 
      %br
      User Name: 
      = v["from_user_name"] 
      %br
      Text: 
      = v["text"] 

