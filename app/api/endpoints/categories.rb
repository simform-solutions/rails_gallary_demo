module Endpoints
  class Categories < Grape::API
    
    resource :categories do
      desc 'Gel all categories' do
        headers AuthenticationToken: {
          description: 'Validates your identity',
          required: true
        }
      end
      get do
        begin
          authenticate!
          return { status:"1", message: "Success", data: Category.all.as_json(only: [:id, :name, :created_at])}
        rescue  => e
          status 500
          return { status:'0', message: e.message, data: []}
        end
      end
    end
  end
end