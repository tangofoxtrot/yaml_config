# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yaml_config}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard"]
  s.date = %q{2009-03-12}
  s.description = %q{Yaml_conf is a simple solution to storing site wide preferences without having to create a new database table or table entry.  Example:  class AdminPref < YamlConfig::Base fields :beta_mode end  @admin_pref = AdminPref.new @admin_pref.beta_mode = true @admin_pref.save}
  s.email = ["richard@tangofoxtrot.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/yaml_config.rb", "lib/yaml_config/base.rb", "lib/yaml_config/class_inheritance.rb", "lib/yaml_config/hash_stringify.rb", "script/console", "script/destroy", "script/generate", "test/fixtures/admin_pref.rb", "test/fixtures/config/adminpref.yml", "test/fixtures/config/sitepref.yml", "test/fixtures/site_pref.rb", "test/test_helper.rb", "test/test_yaml_config.rb"]
  s.has_rdoc = true
  s.homepage = %q{  http://github.com/tangofoxtrot/yaml_config/tree/master}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{yaml_config}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Yaml_conf is a simple solution to storing site wide preferences without having to create a new database table or table entry}
  s.test_files = ["test/test_helper.rb", "test/test_yaml_config.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
