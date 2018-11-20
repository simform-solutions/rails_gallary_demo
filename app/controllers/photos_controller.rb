class PhotosController < ApplicationController
  def create 
    begin
      photo = Photo.create!(photo_params)
      flash[:success] = "Photo uploaded successfully."
      redirect_back fallback_location: { action: "show"}
    rescue  => e
      flash[:alert] = "Invalid attachment." if e.class.to_s == "ActiveRecord::RecordInvalid"
      flash[:alert] = e.message if !e.class.to_s == "ActiveRecord::RecordInvalid"
      redirect_back fallback_location: { action: "show"}
    end   
  end

  def destroy
    Photo.find(params[:id]).destroy
    flash[:alert] = "Photo deleted successfully."
    redirect_back fallback_location: { action: "show"}
  end
 
  #Private methods
  private
  def photo_params
    params.require(:photo).permit(:attachment, :category_id, :id)
  end
end
