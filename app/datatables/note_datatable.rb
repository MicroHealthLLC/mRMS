class NoteDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Note.updated_at
      Note.updated_at
      Note.updated_at
      Note.note
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Note.updated_at
      Note.updated_at
      Note.updated_at
      Note.note
    }
  end

  private

  def data
    records.map do |note|
      [
          @view.link_to( note.object.to_s, note.object),
          @view.link_to_case( note.object.try(:case)),
          note.updated_at.to_date,
          @view.display_note(note.note.to_s),
          @view.show_link(note)
      ]
    end
  end

  def get_raw_records
    Note.where(user_id: [User.current.id, User.current_user.id]).
        where(type: Note::CASES_MODULE)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
