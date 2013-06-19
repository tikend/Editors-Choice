class StaticPagesController < ApplicationController
  require 'will_paginate/array'

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @categories = Category.find_non_empty
      # if(session[:category] == "All")
      # @feed_items = current_user.feed(".*").paginate(page: params[:page])
      # else
      @feed_items = current_user.feed(session[:category]).paginate(page: params[:page])
    # end
    end
  end

  def help
  end

  def news
    @feed_items = Micropost.get_all_news(session[:category])
    @categories = Category.find_non_empty
  end

  def about
  end

  def contact
  end

  def set_category
    if(signed_in?)
      current_user.update_column(:category, params[:name].delete("\n").delete("\t"))
    end
    session[:category] = params[:name].delete("\n").delete("\t")
    # puts session[:category]
    redirect_to root_url
  end
end
