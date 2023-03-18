class Author < ApplicationRecord
    has_many :book_authors
    # through:で中間テーブルを指定
    has_many :books, through: :book_authors
end
