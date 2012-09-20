#encoding: utf-8

# coding: utf-8
class RepliesController < ApplicationController
  # TODO
  #load_and_authorize_resource :reply
  before_filter :find_article

  def find_article
    @article = Article.find(params[:article_id])
  end

  def create
    @reply = @article.replies.build(params[:reply])
    @reply.user_id = current_user.id

    if @reply.save
      @msg = "回复成功"
    else
      @msg = @reply.errors.full_messages.join("<br />")
    end

  end

end