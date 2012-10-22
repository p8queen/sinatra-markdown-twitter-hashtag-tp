# Sinatra

## Introduccion

Sinatra es un framework para aplicaciones web de software libre y código abierto, y escrito en Ruby. Es una alternativa a otros frameworks para aplicaciones webs como Ruby on Rails, Merb, Nitro, Camping, and Rango. 

Diseñado y desarrolado por Blake Mizerany, Sinatra es pequeño y flexible. Sinatra no sigue el típico patrón modelo vista controlador que se ve en otros frameworks, como Ruby on Rails. 
En su lugar, Sinatra se enfoca en la **rápida creación de aplicaciones web en Ruby con el mínimo esfuerzo.**

Algunas destacadas companías que usan Sinatra son: 

- BBC 
- 2 Engine Yard 
- Heroku
- GitHub
- Songbird. 

Heroku provee la mayor parte del apoyo para el desarrollo de Sinatra.

## Ventajas

Sinatra es muy pequeño. Muy pequeño. Alrededor de **1500 líneas de código.**  Rails tiene más de 100.000 líneas de código. Eso es casi 1/100vo el tamaño de Rails.

Sintra es un framework web mínimo y elegante. No incluye cientos de helpers de biblioteca, o un ORM (como ActiveRecord), o cualquier envolturas complejas en las vistas(views). 

Las Aplicaciones de Sinatra a menudo son solo un archivo, incluyendo las vistas(views). 

Las aplicaciones completas varian en decenas, a veces en algunos cientos de líneas de código, incluyendo las vistas.

Usa Ruby y puedes usar instrucciones cómo **requiere** para importar tus clases. 

## Desventajas

Al ser un framework minimalista, no fué pensado para atender un conjunto de problemas, cómo si atienden otros Frameworks, cómo Rails, CakePHP, Django, etc. 
Usa Ruby, que no es el lenguaje más popular, ni el más rápido de los lenguajes de script. 

## Que Soluciona

Desarrollo de pequeñas aplicaciones web. Dónde Rails es demasiado grande y a veces no es necesario todo eso. 
Un framework pequeño es una buena opción para una pequeña aplicación. 
Otro gran uso es el de servicios. Web services deben proporcionar funciones simples y bien definidas. 
Existiendo Sinatra, sería un exceso el uso de Rails para los servicios. 
Velocidad en aprendizaje. Al ser pequeño y simple, en pocos minutos se aprende a usarlo. 

## Ejemplos

~~~~~~~~~~~~~~~~~~~{ #mycode .ruby }
get '/' do
  .. show something ..
end

post '/' do
  .. create something ..
end

put '/' do
  .. replace something ..
end

patch '/' do
  .. modify something ..
end

delete '/' do
  .. annihilate something ..
end

options '/' do
  .. appease something ..
end
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





