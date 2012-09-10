# Introducción Sinatra

Sinatra es un DSL para crear aplicaciones web rápidamente en 
Ruby con un mínimo esfuerzo:

	# miapp.rb
	require 'sinatra'

	get '/' do
	  'Hola mundo!'
	end

--more--

Instalá la gem y ejecutá la aplicación con:

	$ gem install sinatra
	$ ruby -rubygems miapp.rb

Podés verla en: [http://localhost:4567](http://localhost:4567)

Es recomendable además ejecutar gem install thin, ya que Sinatra lo va a utilizar cuando esté disponible.