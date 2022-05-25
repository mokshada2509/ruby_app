class Book < ActiveRecord::Base
    belongs_to :user
    belongs_to :category

    validates :title, presence: true
    validates :description, presence: true
    validates :author, presence: true
end
