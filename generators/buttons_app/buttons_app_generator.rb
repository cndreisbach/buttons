class ButtonsAppGenerator < RubiGen::Base
  BASEDIRS = ['app', 'app/buttons', 'public']

  def initialize(args, opts = {})
    super
    usage if args.empty?
    @destination_root = args.shift
    @app_name = File.basename(File.expand_path(@destination_root))
    @module_name = @app_name.camelize
  end

  def manifest
    record do |m|
      m.directory ''
      BASEDIRS.each { |dir| m.directory dir }

      m.file_copy_each [ 'config.ru',
                         'start.rb',
                         'Rakefile',
                         'public/index.html',
                         'app/buttons/example_button.rb' ]
    end
  end
end
