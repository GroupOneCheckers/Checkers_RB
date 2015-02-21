class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)
    if self.resource
      sign_in(resource_name, resource, store: false)
      render "users/sign_in.json.jbuilder", status: :ok
    else
      render json: { :error => "Authentication Failure!" }, status: :unauthenticated
    end
  end
end
