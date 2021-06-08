class Book < ApplicationRecord
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :favorited_users, through: :favorites, source: :user
    has_many :book_comments, dependent: :destroy
    
    
    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    validates :title, presence: true
    validates :body, presence: true  
    validates :body, length: {maximum: 200 }
    
     scope :created_today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
     scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
     scope :create_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
     scope :create_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day)}
end