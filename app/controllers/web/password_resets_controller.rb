class Web::PasswordResetsController < Web::ApplicationController
  attr_accessor :reset_token

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email])

    if @user
      reset_token = @user.generate_reset_digest

      UserMailer.with({ user: @user, reset_token: reset_token }).password_reset.deliver_now

      flash[:info] = 'Email sent with password reset instructions'
      redirect_to(new_session_path)
    else
      flash.now[:danger] = 'Email address not found'
      render('new')
    end
  end

  def edit
    @user = User.find_by(email: params[:email])

    if !@user.authenticated?(params[:id])
      flash[:danger] = 'Not Found'
      redirect_to(root_path)
    end
  end

  def update
    @user = User.find_by(email: params[:email])

    if @user.update(user_params)
      @user.update(reset_digest: nil)
      flash[:success] = 'Password has been reset.'
      sign_in(@user)
      redirect_to(:board)
    else
      render(:edit)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
