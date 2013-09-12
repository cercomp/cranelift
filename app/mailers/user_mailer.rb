class UserMailer < ActionMailer::Base
  default from: "web@cercomp.ufg.br"

  def password_reset(user)
    @user = user
    mail to: @user.email, :subject => '[Cranelift] Recuperar senha'
  end
end
