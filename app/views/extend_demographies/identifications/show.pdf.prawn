prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @identification.to_pdf(pdf)
end