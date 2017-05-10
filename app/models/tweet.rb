class Tweet < ActiveRecord::Base
    belongs_to :user
    
    validates :content, length:{ maximum: 140}, presence: true, allow_blank: false
end
