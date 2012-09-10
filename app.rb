require 'sinatra'
require 'kramdown'
require 'open-uri'
require 'json'

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

get '/blog' do
  text = "<h1>My Blog</h1>"
  Dir.entries("docs").each do |f|
    if !(f == "." or f == "..")
     doc = File.open("docs/#{f}").read { |file| file.read } 
     text << "<p>" << Kramdown::Document.new(doc).to_html << "</p>"
    end
  end
  text
end

get '/tweeter' do
  ## search hashtag
  haml :tweeter
end

get '/tweeter/search/:hashtag' do
  ## search hashtag
  cantidad = 20
  res_from_tweeter = open("http://search.twitter.com/search.json?rpp=#{cantidad}&q=#{hashtag}").read
  tweets_hash = JSON.parse(res_from_tweeter) #json to hash
  ls_tweeter = tweets_hash["results"]
  haml :tweeter_hashtag, :locals => { :ls_tweeter => ls_tweeter } 
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

@@ tweeter
%h1 tweeter
%form{ :action => "/tweeter/search/", :method => "get"}
  %fieldset
    %ol
      %li
        %label{:for => "hastag"} Hashtag:
        %input{:type => "text", :name => "hastag", :class => "text"}
      %input{:type => "submit", :value => "search", :class => "button"}

@@ tweeter_hashtag
%h1 tweeter
%form{ :action => "/tweeter/search/", :method => "get"}
  %fieldset
    %ol
      %li
        %label{:for => "hastag"} Hashtag:
        %input{:type => "text", :name => "hastag", :class => "text"}
      %input{:type => "submit", :value => "search", :class => "button"}
%p
  resultados:
%p
  - ls_tweeter.each do |v|
    = v["created_at"] 
    = v["from_user_name"] 
    = v["text"] 

