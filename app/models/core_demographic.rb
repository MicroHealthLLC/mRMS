class CoreDemographic < ApplicationRecord
  belongs_to :user

  belongs_to :organization_enum, optional: true, foreign_key: 'organization_id'

  # validates_presence_of :user_id


  after_save do
    user.touch if user
  end
  # validates_presence_of :user

  # TODO remove this on next release

  def organization
    if organization_id
      super
    else
      OrganizationEnum.default
    end
  end


  def self.safe_attributes
    [
        :user_id, :first_name, :last_name, :middle_name,
        :note, :organization_id, user_attributes: [User.safe_attributes]
    ]
  end

  def birthday
    birth_date
  end

  def to_pdf(pdf, show_user = true)
    pdf.table([[ "First name: ", " #{first_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Middle name: ", " #{middle_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Last name: ", " #{last_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Tile: ", " #{title}"]], :column_widths => [ 150, 373])
  end
end
