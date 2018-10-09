class Citation < ApplicationRecord
  belongs_to :term
  belongs_to :source

  validates_presence_of :term, :source
end
