$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'yaml'
require 'fileutils'
require 'yaml_config/hash_stringify'
require 'yaml_config/class_inheritance'
require 'yaml_config/base'

module YamlConfig
  VERSION = '0.1.0'
end