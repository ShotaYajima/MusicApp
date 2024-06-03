class ApplicationController < ActionController::Base
    before_action :set_current_user #各コントローラの全アクションで共通する処理がある場合、アクションが呼び出される際に必ずbefore_actionの処理が実行される

    def set_current_user
        @current_user = User.find_by(id: session[:user_id]) 
    end

    def authenticate_user #ユーザ認証用
        if @current_user == nil
            flash[:notice] = "ログインが必要です"
            redirect_to("/login")
        end
    end

    def forbid_login_user #ログインユーザを禁止する
        if @current_user
            flash[:notice] = "すでにログインしています"
            redirect_to("/posts/index")
        end
    end
end
