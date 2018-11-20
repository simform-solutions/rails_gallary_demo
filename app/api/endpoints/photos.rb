module Endpoints
  class Photos < Grape::API
    resource :photos do
      desc 'Upload photo'do
        headers AuthenticationToken: {
          description: 'Validates your identity',
          required: true
        }
      end
      params do
        requires :category_id, type: Integer, desc: 'Category id.'
        requires :attachment, type: File, desc: 'Upload photo'
      end
      post  do
        begin
          authenticate! 
          is_admin?
          new_file = ActionDispatch::Http::UploadedFile.new(params[:attachment])
          photo = Category.find(params[:category_id]).photos.create!(attachment: new_file)
          return { status:"1", message: "Uploaded attachment successful", data: photo.as_json(only: [:id, :attachment_file_name, :created_at], methods: [:attachment_url])}
        rescue  => e
          if e.class.to_s == "ActiveRecord::RecordNotFound"
            status 404
            return { status:'0', message: "Record not found", data: []}
          end
          status 500
          return { status:'0', message: e.message, data: []}
        end
      end

      desc 'Get all photos' do
        headers AuthenticationToken: {
          description: 'Validates your identity',
          required: true
        }
      end
      params do
        requires :category_id, type: Integer, desc: 'Category id.'
      end
      get do
        begin
          authenticate! 
          safe_params =  clean_params(params).permit(:category_id)
          photos = Category.find(safe_params[:category_id]).photos
          return { status:"1", message: "Successful", data: photos.as_json(only: [:id, :attachment_file_name, :created_at], methods: [:attachment_url])}
        rescue  => e
          if e.class.to_s == "ActiveRecord::RecordNotFound"
            status 404
            return { status:'0', message: "Record not found", data: []}
          end
          status 500
          return { status:'0', message: e.message, data: []}
        end
      end

      desc 'Delete photo' do
        headers AuthenticationToken: {
          description: 'Validates your identity',
          required: true
        }
      end
      params do
        requires :photo_id, type: Integer, desc: 'Photo id.'
      end
      delete do
        begin
          authenticate! 
          is_admin?
          photo = Photo.find(params[:photo_id]).destroy
          return { status:"1", message: "Deleted attachment successful", data:[]}
        rescue  => e
          if e.class.to_s == "ActiveRecord::RecordNotFound"
            status 404
            return { status:'0', message: "Record not found", data: []}
          end
          status 500
          return { status:'0', message: e.message, data: []}
        end
      end
    end
  end
end