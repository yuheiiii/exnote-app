class Image < ApplicationRecord

    validates :user_id,{presence:true}
    has_one_attached :image

    def user
        return User.find_by(id: self.user_id)
    end
end

