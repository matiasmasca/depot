class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params

  before_action :authorize
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

    def authorize
      if [ Mime[:html], Mime[:turbo_stream] ].include? request.format
        unless User.find_by(id: session[:user_id])
          redirect_to login_url, notice: "Please log in"
        end
      else
        authenticate_or_request_with_http_basic do |username, password|
          user = User.find_by(name: username)
          user && user.authenticate(password)
        end
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
end
