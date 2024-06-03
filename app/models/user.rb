class User < ApplicationRecord
    validates :name, presence: { message: "名前を入力してください" } # 名前に関するバリデーション
    validates :user_name, uniqueness: { message: "このユーザーネームは既に使用されています" }, # user_nameの重複に関するバリデーション
        presence: { message: "ユーザーネームを入力してください" } # user_nameの存在に関するバリデーション
    validates :password, presence: { message: "パスワードを入力してください" } # パスワードの存在に関するバリデーション

    def posts
        return Post.where(user_id: self.id)
    end
end
