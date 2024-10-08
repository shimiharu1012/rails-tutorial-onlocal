class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      # 保存の成功の場合
      reset_session
      log_in @user
      flash[:success] ="アカウント登録が完了しました！！"
      redirect_to user_url(@user)
    else
      # 保存に失敗した場合
      render 'new', status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end


