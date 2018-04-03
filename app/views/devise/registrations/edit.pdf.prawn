prawn_document(:page_layout => :portrait) do |pdf|
  User.current.to_pdf_organization(pdf)
  User.current.to_pdf( pdf)
  pdf.move_down 10
  render 'extend_demographies/show', :pdf=> pdf, extend_information: User.current.extend_informations


   pdf.start_new_page  if User.current.jsignatures.present?
    User.current.jsignatures.each do |object|
       object.to_pdf(pdf, "Release of Information")
       pdf.move_down 20
     end
 pdf.start_new_page  if User.current.related_clients.present?
    User.current.related_clients.each do |object|
       object.to_pdf(pdf)
       pdf.move_down 20
     end
end