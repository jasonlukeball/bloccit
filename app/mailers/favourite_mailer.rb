class FavouriteMailer < ApplicationMailer

  default from: "jasonlukeball@me.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@bloccit.jasonlukeball.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@bloccit.jasonlukeball.com>"
    headers["References"] = "<post/#{post.id}@bloccit.jasonlukeball.com>"

    @user     = user
    @post     = post
    @comment  = comment

    mail(to: user.email, subject: "New comment on #{post.title}")

  end

end
