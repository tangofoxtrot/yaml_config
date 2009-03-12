module YamlConfig


  # Declare your own YAML-based model by inheriting from YamlModel::Base.
  #
  # Example: 
  #   class Book < YamlModel::Base
  #     fields :title, :author, :content
  #   end
  class Base
    
    include ClassLevelInheritableAttributes
    inheritable_attributes :before_save_hooks, :after_save_hooks
    @before_save_hooks = []
    @after_save_hooks = []

    def initialize(attributes = {})
      @yaml_attributes = self.class.setup
      @yaml_attributes.merge!(attributes.stringify_keys)
      @attributes = @yaml_attributes
    end

    # Run this method to declare the fields of your model.
    # Example: 
    #   class Book < YamlModel::Base
    #     fields :title, :author, :content
    #   end
    def self.fields(*fields)
      fields.each do |field|
        define_method field do
          @attributes[field.to_s]
        end
        define_method "#{field}=" do |value|
          @attributes[field.to_s] = value
        end        
      end
    end
    
    
    def self.before_save(*meths)
      self.before_save_hooks =  self.before_save_hooks + meths.flatten
    end

    def self.after_save(*meths)
      self.after_save_hooks =  self.after_save_hooks + meths.flatten
    end
    
    @@data_dir = "#{defined?(RAILS_ROOT) ? RAILS_ROOT : File.dirname(__FILE__) }/config/"

    # Run this method to point to a different data directory than
    # RAILS_ROOT/data/ or to return the data_dir (if no argument is given)
    def self.data_dir(path = nil)
      @@data_dir = path unless path.to_s.size == 0
      @@data_dir += '/' unless @@data_dir =~ /\/$/
      @@data_dir
    end

    # Returns the full path to the data file.
    def self.data_file
      File.expand_path("#{data_dir}#{name.downcase}.yml")
    end

    def save
      initiate_before_save
      File.open(self.class.data_file, 'w') do |file|
        file.write @attributes.to_yaml
      end
      initiate_after_save
    end

    private

    def self.setup
      create_file
      load_yaml
    end
    
    # Creates the data file, if it doesn't exist yet.
    def self.create_file
      FileUtils.mkdir_p(data_dir)
      File.open(data_file, 'a')
    end
    

    def self.load_yaml
      return YAML.load_file(data_file) || {}
    end
    
    def initiate_before_save     
      self.class.before_save_hooks.each do |hook|
        self.send(hook)
      end
    end

    def initiate_after_save
      self.class.after_save_hooks.each do |hook|
        self.send(hook)
      end
    end
    
  end  
  
end