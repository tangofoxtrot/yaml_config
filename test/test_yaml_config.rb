require File.dirname(__FILE__) + '/test_helper.rb'

class TestYamlConfig < Test::Unit::TestCase
  
  def setup
    @before_dir = AdminPref.data_dir    
    @admin_pref = AdminPref.new 
  end

  def teardown
    AdminPref.data_dir(@before_dir)
    admin = AdminPref.new({:beta_mode => true, :not_listed => "something"})
    admin.save
  end
  
  def test_loads_file
    assert_equal @admin_pref.beta_mode, true
  end

  def test_doesnt_care_about_non_defined_fields
    assert_raise(NoMethodError) {
      @admin_pref.not_listed
    }
  end
  
  def test_creates_directory_if_doesnt_exist
    AdminPref.data_dir('test/fixtures/config/data') 
    @admin_pref = AdminPref.new
    assert_equal AdminPref.data_file, File.expand_path(File.dirname(__FILE__) + "/fixtures/config/data/adminpref.yml")
    assert File.exists?(AdminPref.data_file)
    FileUtils.remove_dir('test/fixtures/config/data')
  end
  
  def test_creates_file_if_doesnt_exist # essentially the same test as above
    AdminPref.data_dir('test/fixtures/config/data') 
    @admin_pref = AdminPref.new
    assert File.exists?(AdminPref.data_file)
    FileUtils.remove_dir('test/fixtures/config/data')    
  end
  
  def test_merges_attributes_on_new_instance
    @admin_pref = AdminPref.new({:beta_mode => false})
    assert_equal @admin_pref.beta_mode, false
  end
  
  def test_save_attributes
    @admin_pref.beta_mode = false
    @admin_pref.save
    @other_admin_pref = AdminPref.new
    assert_equal @other_admin_pref.beta_mode, false
    @admin_pref.beta_mode = true
    @admin_pref.save
  end
  
  def test_save_with_nil_attributes
    @admin_pref.beta_mode = nil
    @admin_pref.save
    @other_admin_pref = AdminPref.new
    assert_equal @other_admin_pref.beta_mode, nil
    @admin_pref.beta_mode = true
    @admin_pref.save    
  end
  
  def test_override_data_file
    assert_equal AdminPref.data_dir('Bananas'), 'Bananas/'
  end
  
  def test_before_save_hooks
    reset_site_pref
    assert_equal @site_pref.example_before_hook_attribute, nil
    @site_pref.save
    @after_site_pref = SitePref.new
    assert_equal @after_site_pref.example_before_hook_attribute, "Bananas"    
  end
  
  def test_after_save_hooks
    reset_site_pref
    assert_equal @site_pref.example_after_hook_attribute, nil
    @site_pref.save
    assert_equal @site_pref.example_after_hook_attribute, "Bananas"        
  end
  
  def test_config
    assert_equal AdminPref.config['beta_mode'], true 
  end

  def test_saving_sets_config
    @admin_pref.beta_mode = false
    @admin_pref.save    
    assert_equal AdminPref.config['beta_mode'], false
  end
  
protected
  
  def reset_site_pref
    @site_pref = SitePref.new({:comments_to_show => 10, :example_before_hook_attribute => nil, :example_after_hook_attribute => nil}) 
  end
  
  
end
