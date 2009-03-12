class SitePref < YamlConfig::Base
  fields :comments_to_show, :example_before_hook_attribute, :example_after_hook_attribute

  before_save :set_example_before_hook_attribute
  after_save :set_example_after_hook_attribute
  
  
  def set_example_before_hook_attribute
    self.example_before_hook_attribute = "Bananas"
  end
  
  def set_example_after_hook_attribute
    self.example_after_hook_attribute = "Bananas"
  end
  
end