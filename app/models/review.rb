class Review < ActiveRecord::Base
    belongs_to :book
    belongs_to :user

    validates :rating, presence: true
    validates :comment, presence: true
end
