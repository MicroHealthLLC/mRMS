prawn_document(:page_layout => :portrait) do |pdf|
   table= [['ID', 'Name', 'Email', 'login', 'Role', 'status']]
   User.all.each do |user|
    table<< [user.uuid, user.full_name, user.email, user.login, user.role.to_s, user.active?]
   end

   pdf.table(table, cell_style: {columns_width: [90,90,90,90,90] })
end