class Notifier < ActionMailer::Base
  default from: 'papayalabs@gmail.com'

  def guest_list(recipient)
    mail(to: 'papayalabs@gmail.com',
         subject: "[Pymenta] - Lista de invitados",
         body: "#{recipient} quiere estar en la lista de invitados" )
  end
  
  def welcome_email(user)
    @user = user 
    I18n.with_locale(I18n.locale) do
      mail(to: @user.email,
           subject: I18n.t("helpers.labels.welcome_subject"),
           body: I18n.t("helpers.labels.welcome_body"))
    end
  end
  
end