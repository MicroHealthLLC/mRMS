class Fax < ApplicationRecord
  belongs_to :fax_type
  belongs_to :extend_demography

  validates_presence_of :fax_number, :fax_type_id
  validates_uniqueness_of :fax_number, scope: [:fax_type_id, :extend_demography_id]
  validates_uniqueness_of :fax_type_id, scope: [:extend_demography_id]

  def self.safe_attributes
    [:id, :fax_type_id, :fax_number, :note, :_destroy]
  end

  def to_html
    output = "<div class='col-xs-12'>"
    output<< "<div class='col-xs-2'>#{fax_type} </div>"
    output<< "<div class='col-xs-8'>#{fax_number} </div>"
    output<< "</div>"
    output.html_safe
  end

  def fax_type
    if fax_type_id
      super
    else
      FaxType.default
    end
  end

  def to_pdf(pdf, show_user = true)
    pdf.table([[ "fax type:", " #{fax_type}", " Fax number:", " #{fax_number}"]], :column_widths => [ 100,150, 100, 173])
  end

end
