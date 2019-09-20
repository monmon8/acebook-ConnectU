class UsersController < Clearance::UsersController
  def create
    # completely overwriting it
    @user = user_from_params

    if @user.save
      sign_in @user
      flash[:message] = 'A helpful message to say you\'ve been signed in!'
      redirect_back_or url_after_create
    else
      flash[:error] = "Unable to create account"
      redirect_to sign_up_path
    end
  end

  # protected
  def url_after_create
    "/profile"
  end

  def show
      @post = Post.new
      @posts = Post.where(:user_id => params[:user_id]).order("created_at DESC")
  end
end
