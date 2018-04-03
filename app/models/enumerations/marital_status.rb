class MaritalStatus < Enumeration
  has_many :core_demographics

  OptionName = :enumeration_marital_status

  def option_name
    OptionName
  end

  def objects
    CoreDemographic.where(:marital_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:marital_status_id => to.id)
  end
end