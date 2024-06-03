Rails.application.routes.draw do

  get "login" => "users#login_form" #ログインフォームへの遷移

  post "login" => "users#login"

  post "logout" => "users#logout" #ログアウトページへの遷移

  get "logout" => "users#logout"

  post "users/:id/update" => "users#update"

  get "users/:id/edit" => "users#edit"  #会員情報の編集

  post "users/create" => "users#create"# 新規会員登録の保存

  get "signup" => "users#new" #新規登録

  get "users/index" => "users#index"

  get "users/:id" => "users#show" 

  get "posts/index" => "posts#index"

  get "posts/new" => "posts#new" #新規投稿ページへのルート

  get "posts/:id" => "posts#show" #投稿詳細ページへのルート

  post "posts/create" => "posts#create" #データベースへ送信するためのルート

  get "posts/:id/edit" => "posts#edit" #編集したいidを含むURLを編集へ移すためのルート

  post "posts/:id/update" => "posts#update" #編集した内容をアップデート
  
  get "posts/:id/destroy" => "posts#destroy" #投稿を削除する

  get "/" => "home#top" #ローカルホスト3000ではなく最初からトップ画面に遷移させる
  get "about" => "home#about"

end
