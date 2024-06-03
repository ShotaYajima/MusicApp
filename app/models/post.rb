class Post < ApplicationRecord
        validates :content, presence: { message: "内容を入力してください" }, 
                            length: { maximum: 140, message: "140文字以内で入力してください" }
        validates :user_id, presence: { message: "ユーザーIDが必要です" }
      

    def user
        return User.find_by(id: self.user_id)
    end
end
  