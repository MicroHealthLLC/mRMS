class  IdentificationStatus < Enumeration
  has_many :identifications

  OptionName = :enumeration_identification_status

  def option_name
    OptionName
  end

  def objects
    Identification.where(:identification_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:identification_status_id => to.id)
  end
end