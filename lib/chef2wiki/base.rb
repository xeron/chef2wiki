class Chef2Wiki

  attr_reader :wiki, :config, :templates, :options

  GEM_DATADIR = Gem.datadir("chef2wiki") || "data"
  GEM_HOMEDIR = File.join(ENV["HOME"], ".chef2wiki")
  DEFAULT_CONFIG_PATH = File.join(GEM_HOMEDIR, "config.yml")
  DEFAULT_TEMPLATES_PATH = File.join(GEM_HOMEDIR, "templates")

  def initialize(options = {})
    options[:config] ||= DEFAULT_CONFIG_PATH
    options[:templates] ||= DEFAULT_TEMPLATES_PATH
    options[:wiki] ||= :mediawiki

    @options = options
    @config = read_config(File.expand_path(options[:config]))
    @templates = register_templates(File.expand_path(options[:templates]))
    @wiki = case options[:wiki]
    when :mediawiki
      setup_media_wiki
    end

    Chef::Config.from_file(File.expand_path(config["chef"]["config"]))
  end

  # Render node.
  #
  # ==== Attributes
  # * +node+ - Node name (String)
  def render_node(node)
    puts "[Chef2Wiki]\tWorking for node #{node}..."
    @data = node_data(node)
    templates["node"].result(binding)
  end

  private

  # Read chef2wiki config file. Create default config if missing.
  #
  # ==== Attributes
  # * +path+ - path for chef2wiki config file
  # ==== Returns
  # * Config data (Hash)
  def read_config(path)
    unless File.exist?(path)
      puts "[Chef2Wiki]\tCreating config file at #{path}..."
      FileUtils.mkdir_p(File.dirname(path))
      FileUtils.cp(File.join(GEM_DATADIR, "config.yml"), path)
    end

    YAML::load_file(path)
  end

  # Register templates from templates folder. Create default templates if missing.
  #
  # ==== Attributes
  # * +path+ - path for erb templates
  # ==== Returns
  # * Templates data (Hash)
  def register_templates(path)
    unless File.directory?(path)
      puts "[Chef2Wiki]\tCreating default templates at #{path}..."
      FileUtils.mkdir_p(path)
      FileUtils.cp_r(File.join(GEM_DATADIR, "templates", "."), path)
    end

    templates_data = {}
    Dir.glob(File.join(path, "*.erb")) do |file|
      name = File.basename(file, ".erb")
      begin
        templates_data[name] = ERB.new(File.read(file), nil, "%<>")
      rescue => ex
        puts "[Chef2Wiki]\tError loading template #{tem}: " + ex.to_s
      end
    end
    puts "[Chef2Wiki]\tRegistered templates: #{templates_data.keys.join(", ")}"
    return templates_data
  end

  # Render partial template.
  #
  # ==== Attributes
  # * +name+ - Name of template (String)
  def render(name)
    puts "[Chef2Wiki]\tRendering partial #{name}..."
    template = ERB.new(File.read(File.join(options[:templates], name)), nil, "%<>")
    template.result(binding)
  end

  # Recursively print Hash in wiki format
  # If value class is a Hash - call this method again
  # If value class is an Array - print it with join
  #
  # ==== Attributes
  # * +obj+ - Object for print (Hash)
  # * +point+ - String for start of the line (String)
  # * +splitter+ - String for attribute and value splitting (String)
  # * +endline+ - String for end of the line (String)
  def print_attrs(obj, point="*", splitter=":", endline="\n")
    result = ""
    if obj.is_a?(Hash)
      obj.each do |arg, value|
        result += "#{point} #{arg}#{splitter} "
        result += case value
        when Hash
          "#{endline}#{print_attrs(value, point[0,1]+point, splitter, endline)}"
        when Array
          "#{value.join(", ")}#{endline}"
        else
          "#{value}#{endline}"
        end
      end
    end
    return result
  end

end
