class NoteTemplate < ApplicationRecord
 # include OrganizationConcern
  def self.safe_attributes
    [:title, :note]
  end


end
