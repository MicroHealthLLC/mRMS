module MenuHelper

  def module_enabled?(module_name)
    @enabled_modules = EnabledModule.active.pluck(:name).to_set if @enabled_modules.nil?
    @enabled_modules.include?(module_name)
  end

end