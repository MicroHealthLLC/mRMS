class CoreDemographic < ApplicationRecord
  belongs_to :user
  # belongs_to :user_profile, foreign_key: :user_id, class_name: 'User'
  # accepts_nested_attributes_for :user
  # TODO remove those on next release
  belongs_to :religion_type, foreign_key: :religion_id, optional: true
  belongs_to :ethnicity_type, foreign_key: :ethnicity_id, optional: true


  belongs_to :gender_type, foreign_key: :gender_id, optional: true
  belongs_to :citizenship_type, optional: true
  belongs_to :marital_status, optional: true
  belongs_to :civility_title, optional: true

  # validates_presence_of :user_id


  after_save do
    user.touch if user
  end
  # validates_presence_of :user

  # TODO remove this on next release
  def religion_type
    if religion_id
      super
    else
      ReligionType.default
    end
  end

  def civility_title
    if civility_title_id
      super
    else
      CivilityTitle.default
    end
  end

  def marital_status
    if marital_status_id
      super
    else
      MaritalStatus.default
    end
  end

  def age
    dob = birthday.to_date rescue Date.today
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end


  def gender_type
    if gender_id
      super
    else
      GenderType.default
    end
  end

  def citizenship_type
    if citizenship_type_id
      super
    else
      CitizenshipType.default
    end
  end

  # TODO remove this on next release
  def ethnicity_type
    if ethnicity_id
      super
    else
      EthnicityType.default
    end
  end

  def self.safe_attributes
    [
        :user_id, :first_name, :last_name, :middle_name,
        :gender, :title, :marital_status_id, :civility_title_id,
        :birth_date, :religion,
        :note, :ethnicity, :citizenship_type_id, :height, :weight, user_attributes: [User.safe_attributes]
    ]
  end

  def birthday
    birth_date
  end

  def to_pdf(pdf, show_user = true)
    pdf.table([[ "First name: ", " #{first_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Middle name: ", " #{middle_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Last name: ", " #{last_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Gender: ", " #{gender}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Birthday: ", " #{birthday}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Religion: ", " #{religion}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Marital Status: ", " #{marital_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Tile: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Ethnicity: ", " #{ethnicity}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Citizenship: ", " #{citizenship_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end
end
