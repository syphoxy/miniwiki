require 'sinatra'
require 'haml'
require 'wikicloth'
require 'json'
require 'uri'

wiki_logo = 'logo.png'
wiki_name = 'Wiki'
use_identicon = false
css = true
js = true
noindex = false
base_url = ''
custom_path = ''
upload_dest = 'uploads'
url_path_display = nil
mathjax = false
mathjax_config = nil
allow_uploads = true
allow_editing = true

stylesheets = [
  {media: 'all',   href: base_url + '/css/gollum.css'},
  {media: 'all',   href: base_url + '/css/editor.css'},
  {media: 'all',   href: base_url + '/css/dialog.css'},
  {media: 'all',   href: base_url + '/css/template.css'},
  {media: 'print', href: base_url + '/css/print.css'},
  {media: 'all',   href: 'https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.7/semantic.min.css'},
]

stylesheets << {media: 'all', href: custom_path + '/custom.css'} if css

scripts = [
  base_url + '/javascript/jquery-1.7.2.min.js',
  base_url + '/javascript/mousetrap.min.js',
  base_url + '/javascript/gollum.js',
  base_url + '/javascript/gollum.dialog.js',
  base_url + '/javascript/gollum.placeholder.js',
  base_url + '/javascript/editor/gollum.editor.js',
  'https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.7/semantic.min.js',
]

scripts << base_url + '/javascript/identicon_canvas.js' if use_identicon
scripts << base_url + '/' + mathjax_config if mathjax and ! mathjax_config.nil?
scripts << base_url + '/custom.js' if js

template_data = {
  wiki_logo: wiki_logo,
  wiki_name: wiki_name,
  stylesheets: stylesheets,
  scripts: scripts,
  base_url: base_url,
  noindex: noindex,
  upload_dest: upload_dest,
  url_path_display: url_path_display,
  use_identicon: use_identicon,
  mathjax: mathjax,
  mathjax_config: mathjax_config,
  allow_uploads: allow_uploads,
  allow_editing: allow_editing,
}

get '/create/:path' do
  'Create: '+ params['path']
end

get '/edit/:path' do
  'Edit: ' + params['path']
end

get '/:path' do
  template_data[:editable] = true
  template_data[:page_exists] = true
  template_data[:page_title] = 'Hello World!'
  haml :index, locals: template_data
end

get '/' do
  redirect '/Home', 303
end
