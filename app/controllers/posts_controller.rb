class PostsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def index 
  end 

  def create
    @post = current_user&.posts.build(post_params) # Associate post with current user
    if @post.save
      send_new_post_emails(@post)
      render json: { message: 'Post created and emails sent.' }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id, images: [])
  end

  def send_new_post_emails(post)
    User.all.each do |user|
      PostMailer.new_post_email(post, user).deliver_later
    end
  end

  def authenticate_user!
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      decoded_token = JWT.decode(token, nil, false)
      user_id = decoded_token[0]['sub']
      @current_user = User.find_by(id: user_id)
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
end
