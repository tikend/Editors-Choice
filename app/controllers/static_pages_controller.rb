class StaticPagesController < ApplicationController
  require 'will_paginate/array'


  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      if(current_user.category == "All")
        @feed_items = current_user.feed(".*").paginate(page: params[:page])
      else
        @feed_items = current_user.feed(current_user.category).paginate(page: params[:page])
      end
      @categories = Category.find(:all, :order => "name")
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def setCategory
    # current_user.set_category(params[:name].delete("\n").delete("\t"), current_user)
    # current_user.category = params[:name].delete("\n").delete("\t")
    current_user.update_column(:category, params[:name].delete("\n").delete("\t"))
  end
end
