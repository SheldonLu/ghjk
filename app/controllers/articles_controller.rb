# coding: utf-8

class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    #tags = @article.tags.split(" ")
    @article.user_id = current_user.id

    if @article.save
      redirect_to(article_path(@article.id), :notice => "article 创建成功")
    else
      render :action => "new"
    end
  end

  def show
    @article = Article.find(params[:id])
    @replies = @article.replies
  end

  def recent
    @articles = Article.recent
    render :action => "index"
  end

  def hot
    # high_likes
    @articles = Article.by_week.high_replies
    render :action => "index"
  end
  
  def reply
    @article = Article.find(params[:id])
    @replies = @article.replies
        
  end
  
end