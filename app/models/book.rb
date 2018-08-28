class Book < ApplicationRecord
  #associating book with user
  belongs_to :user
  #associating book and category
  belongs_to :category
end
