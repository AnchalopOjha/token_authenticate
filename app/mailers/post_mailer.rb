class PostMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def new_post_email(post, user)
        
      @post = post
      @user = user
      mail(to: @user.email, subject: 'A New Post Has Been Created')
    end
end
