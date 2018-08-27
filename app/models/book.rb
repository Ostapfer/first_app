class Book < ApplicationRecord
    validates :name, presence: true, length: {minimum: 2, message: "Must be 2 or more sym"}
    validates :description, presence: true, length: {minimum: 5, message: "Must be 5 or more sym"}

    belongs_to :user
    has_many :lists
    #has_many :users, through: :lists
end
