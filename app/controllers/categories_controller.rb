class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @photos = Category.find(params[:id]).photos
    @photo = Photo.new(category_id: params[:id])
  end
end
