class Book < ApplicationRecord
  #associating book with user
  belongs_to :user
  #associating book and category
  belongs_to :category
  has_many :reviews

  #Paper Clip
  has_attached_file :book_img, styles: { :book_index => "250x350>", :book_show => "325x475>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, :content_type => /\Aimage\/.*\z/
end
