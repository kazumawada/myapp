module Helpers

    #認証されるユーザー。ただのデータ。アクションなし。
    def sign_in_as
        user = User.create(name: "main-user",
                           email: "main-user@example.com",
                           password: "password",
                           password_confirmation: "password",
                           year: "1年",
                           bio: "hello!")
    end

    def other_user
        user = User.create(name: "簡単ログインしたユーザー",
            email: "smooth_login@example.com",
            password: "password",
            password_confirmation: "password",
            year: "1年",
            bio: "hello!")
    end



    # ログインする
   def sign_in_as(user)
    post login_path, params: { session: { email: user.email,
                                        　password: user.password } }
   end

  

end

 # LoginSupportモジュールをincludeする
 RSpec.configure do |config|
    config.include Helpers
  end