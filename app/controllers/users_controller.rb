class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = 'Welcome to AtCoder Standings!'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    # FIXME: 現状、エラーとなる入力に対しても、更新ができてしまう
    if @user.update(user_params)
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user)
            .permit(:name, :atcoder_id, :password, :password_confirmation)
    end
end
