class Address < ApplicationRecord
  belongs_to :address_type
  belongs_to :state_type, foreign_key: :state_id
  belongs_to :country_type, foreign_key: :country_id
  belongs_to :extend_demography

  validates_presence_of :address, :address_type_id
  validates_uniqueness_of :address, scope: [:address_type_id, :extend_demography_id]
  validates_uniqueness_of :address_type_id, scope: [:extend_demography_id]


  def self.safe_attributes
    [:id, :address_type_id, :address, :second_address,
     :zip_code, :state, :location_lat, :location_long,
     :city, :country_code, :state_id, :country_id, :_destroy]
  end

  def address_type
    if address_type_id
      super
    else
      AddressType.default
    end
  end

  def city_state_zip
    return "#{city}, #{state} #{zip_code}" if city
    "#{state} #{zip_code}"
  end

  def state_type
    if state_id
      super
    else
      StateType.default
    end
  end

  def country_type
    if country_id
      super
    else
      CountryType.default
    end
  end


  def full_address
    output = ""
    output<< "#{address}, " if address.present?
    # output<< "#{second_address}, " if second_address.present?
    # output<< "#{city}, " if city.present?
    # output<< "#{zip_code}" if zip_code.present?
    output
  end

  def to_s
    "(#{address_type}) #{full_address}"
  end

  def to_html
    output = "<div class='col-xs-12'>"
    output<< "<div class='col-xs-2'>#{address_type} </div>"
    # output<< "<div class='col-xs-8'>#{full_address} </div>"
    # output<< "<div class='col-xs-2'>#{state_type}  #{country_type} </div>"
    output<< "</div>"
    output.html_safe
  end

  def to_pdf(pdf, show_user = true)
    pdf.table([[ "Address type:", " #{address_type} ", " Address:", " #{full_address}"]], :column_widths => [ 100,150, 100, 173])
  end

end
