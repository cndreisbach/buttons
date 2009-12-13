require File.join(File.dirname(__FILE__), 'start')

files = Dir.chdir('public') { Dir['**/*'].map { |file| "/#{file}" } }
app = Buttons.app do
  use Rack::Static, :root => 'public', :urls => files
end

run app
