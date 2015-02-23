class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def authenticate_user_from_token!
    user_token = request.headers['Authentication-token']
    user_token ||= params[:authentication_token].presence
    user       = user_token && User.find_by_authentication_token(user_token)

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    else
      render json: { :error => "Authentication Failure!" },
        status: :unauthenticated
    end
  end

  Warden::Manager.after_authentication do |user,auth,opts|
    user.last_seen = Time.now
    user.save
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: nil, status: :not_found
  end

  private
  def set_format!
    params[:format] = 'json'
  end

  def update_last_seen
    current_user.last_seen = Time.now
    current_user.save
  end

end
