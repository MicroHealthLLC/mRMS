
prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  User.current.to_pdf_brief_info(pdf)
  @identifications.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
end