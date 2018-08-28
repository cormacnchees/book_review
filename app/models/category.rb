class Category < ApplicationRecord
    #associating category with books
    has_many :books
end
