class ProfilesController < ApplicationController
  skip_before_action :authorize, only: %i(new create)

  include Rest

  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  private

  def find_resource
    current_user
  end

  def resource_class
    User
  end

  def permitted_attributes
    %i(
      first_name
      last_name
      email
      password
      phone
      level
      location
      school
      role
      since
      about
    )
  end

  def after_path
    profile_path
  end

  def created
    UserMailer.welcome(@user).deliver_later
    login(@user.create_device)
  end
end