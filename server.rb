require 'sinatra'
require 'haml'
require 'wikicloth'
require 'json'
require 'uri'

before do
  @config = {
    wiki_logo: 'logo.png',
    wiki_name: 'Wiki',
    use_identicon: false,
    css: true,
    js: true,
    noindex: false,
    base_url: '',
    custom_path: '',
    upload_dest: 'uploads',
    mathjax: false,
    mathjax_config: nil,
    allow_uploads: true,
    allow_editing: true,
  }

  @stylesheets = [
    {media: 'all', href: @config[:base_url] + '/css/gollum.css'},
    {media: 'all', href: @config[:base_url] + '/css/editor.css'},
    {media: 'all', href: @config[:base_url] + '/css/dialog.css'},
    {media: 'all', href: @config[:base_url] + '/css/template.css'},
    {media: 'print', href: @config[:base_url] + '/css/print.css'},
    {media: 'all', href: 'https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.7/semantic.min.css'},
  ]

  @stylesheets << {media: 'all', href: @config[:custom_path] + '/custom.css'} if @config[:css]

  @scripts = [
    @config[:base_url] + '/javascript/jquery-1.7.2.min.js',
    @config[:base_url] + '/javascript/mousetrap.min.js',
    @config[:base_url] + '/javascript/gollum.js',
    @config[:base_url] + '/javascript/gollum.dialog.js',
    @config[:base_url] + '/javascript/gollum.placeholder.js',
    @config[:base_url] + '/javascript/editor/gollum.editor.js',
    'https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.7/semantic.min.js',
  ]

  @scripts << @config[:base_url] + '/javascript/identicon_canvas.js' if @config[:use_identicon]
  @scripts << @config[:base_url] + '/' + @config[:mathjax_config] if @config[:mathjax] and ! @config[:mathjax_config].nil?
  @scripts << @config[:base_url] + '/custom.js' if @config[:js]
end

get '/create/:path' do
  'Create: '+ params['path']
end

get '/edit/:path' do
  'Edit: ' + params['path']
end

get '/:path' do
  haml :index, locals: {
    config: @config,
    page: {
      stylesheets: @stylesheets,
      scripts: @scripts,
      editable: true,
      exists: true,
      title: params['path'],
      body: mediawiki('= ' + params['path'] + ' =')
    }
  }
end

get '/' do
  redirect '/Home', 303
end
