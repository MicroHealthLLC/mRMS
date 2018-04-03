class CivilityTitle < Enumeration
  has_many :core_demographics

  OptionName = :enumeration_civility_title

  def option_name
    OptionName
  end

  def objects
    CoreDemographic.where(:civility_title_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:civility_title_id => to.id)
  end
end