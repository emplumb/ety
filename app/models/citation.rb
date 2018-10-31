class Citation < ApplicationRecord
  belongs_to :term
  belongs_to :source

  validates_presence_of :term, :source
  validates :term_id, uniqueness: { scope: :source_id, message: "This source has already been associated to this entry" }

end
