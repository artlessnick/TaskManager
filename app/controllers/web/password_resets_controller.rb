class Web::PasswordResetsController < Web::ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_token, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to(new_session_path)
    else
      flash.now[:danger] = 'Email address not found'
      render('new')
    end
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add(:password, 'cant be empty')
    elsif @user.update(user_params)
      @user.update(reset_digest: nil)
      flash[:success] = 'Password has been reset.'
      sign_in(@user)
      redirect_to(:board)
    else
      flash[:success] = 'does not match Password'
      render(:edit)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_token
    return if @user.authenticated?(params[:id])

    flash[:danger] = 'Not Found'
    redirect_to(root_path)
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'Password reset has expired.'
      redirect_to(new_password_reset_path)
    end
  end
end
