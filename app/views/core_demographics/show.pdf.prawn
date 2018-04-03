prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @core_demographic.to_pdf( pdf)
end