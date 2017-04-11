require 'sinatra'
require 'haml'
require 'wikicloth'

get '/create/:path' do
  "Create: "+ params['path']
end

get '/edit/:path' do
  "Edit: " + params['path']
end

get '/:path' do
  haml :index, locals: { text: mediawiki("= hello world =\n== foo bar ==\n") }
end

get '/' do
  redirect '/Home', 303
end
