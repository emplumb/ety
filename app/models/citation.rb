class Citation < ApplicationRecord
  belongs_to :term
  belongs_to :source
end
