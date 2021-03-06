class UsersController < ApplicationController
  include Rest

  def index
    @query = params[:query]
    @users = User.search(@query).page(params[:page])
  end

  def show
    @diagnostics = @user.diagnostics.order(created_at: :desc).page(params[:page])
  end

  private

  def permitted_attributes
    %i(name email password)
  end

  def created
    UserMailer.welcome(@user).deliver_later
    @device = @user.create_device
    login(@device)
  end

  def deleted
    logout if @user == current_user
  end

  def after_path
    case action_name.to_sym
    when :create, :update then configure_path
    when :destroy         then root_path
    end
  end
end
