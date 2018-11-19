class API < Grape::API
  prefix 'api'
  format :json
  version 'v1', using: :path

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end
  
  helpers do
    def clean_params(params)  
      ActionController::Parameters.new(params)
    end  

    def current_user
      return nil if headers['Authenticationtoken'].nil?
      User.find_by_authentication_token(headers['Authenticationtoken'])
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
    
    def is_admin?
      user = User.find_by_authentication_token(headers['Authenticationtoken'])
      if user.roles.first.name == "admin" 
        user 
      else 
        error!('401 Unauthorized', 401)
        end
    end
  end

  mount Endpoints::Users
  mount Endpoints::Categories
  mount Endpoints::Photos

  add_swagger_documentation	api_version: 'v1',                          
    info: 
    {
      title: 'Gallary',
      description: 'List of APIs for Gallary'									    
    },
    base_path: nil,
    array_use_braces: true
end