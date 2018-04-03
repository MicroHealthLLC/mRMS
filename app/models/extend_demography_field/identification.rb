class Identification < ApplicationRecord
  belongs_to :identification_type, optional: true
  belongs_to :identification_status, optional: true
  belongs_to :issued_by_type, optional: true
  belongs_to :extend_demography, optional: true

  validates_presence_of :identification_number, :identification_type_id
  validates_uniqueness_of :identification_type_id, scope: [:extend_demography_id]

  def self.safe_attributes
    [:id, :identification_number, :status, :date_expired, :issued_by_type_id, :date_issued, :note, :identification_type_id, :identification_status_id, :_destroy]
  end

  def self.include_enumerations
    includes(:issued_by_type, :identification_type, :identification_status).
        references(:issued_by_type, :identification_type, :identification_status)
  end

  def to_html
    output = "<div class='col-xs-12'>"
    output<< "<div class='col-xs-2'>#{identification_type} </div>"
    output<< "<div class='col-xs-2'>#{identification_number} </div>"
    output<< "<div class='col-xs-2'>#{status} </div>"
    output<< "<div class='col-xs-2'>#{date_expired} </div>"
    output<< "<div class='col-xs-2'>#{issued_by_type} </div>"
    output<< "<div class='col-xs-2'>#{date_issued} </div>"
    output<< "</div>"
    output.html_safe
  end

  def identification_type
    if identification_type_id
      super
    else
      IdentificationType.default
    end
  end

  def identification_status
    if identification_status_id
      super
    else
      IdentificationStatus.default
    end
  end

  def to_s
    identification_type.to_s
  end

 def issued_by_type
    if issued_by_type_id
      super
    else
      IssuedByType.default
    end
  end



  def to_pdf(pdf, show_user = true)
    pdf.table([[ "Identification type:", " #{identification_type}", " Id number:", " #{identification_number}"]], :column_widths => [ 100,150, 100, 173])
  end

end
