class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  private

    def set_locale
      if params[:locale].present?
        I18n.locale = params[:locale]
      elsif request.env['HTTP_ACCEPT_LANGUAGE'].present?
        I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'][/^[a-z]{2}/]
      else
        I18n.locale = I18n.default_locale
      end

      Rails.application.routes.default_url_options[:locale] = I18n.locale
      ActionMailer::Base.default_url_options[:locale] = I18n.locale
      # current_user.locale
      # request.subdomain
      # request.remote_ip
    end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

def after_sign_in_path_for(resource)
  users_path() #your path
end

end
