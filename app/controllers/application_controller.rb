class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do |exception|
    puts exception.backtrace
    respond_to do |format|
      format.html { render file: "public/404.html", status: 404 }
      format.json { render json: {}, status: 404}
    end
  end
end
