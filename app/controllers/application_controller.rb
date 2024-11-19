class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!

  # Redirigir después de iniciar sesión
  def after_sign_in_path_for(resource)
    articles_path # Esto redirige a la lista de artículos
  end
  allow_browser versions: :modern
end
