prawn_document(:page_layout => :portrait) do |pdf|
    @news.to_pdf(pdf)
end