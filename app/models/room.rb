class Room < ApplicationRecord
    has_secure_password
    validates :room_id, {presence:true, uniqueness:true}
    validates :password,{presence:true,}
    has_one_attached :image
   
    
    def user
        return User.find_by(id: self.user_id)
    end
    

end
