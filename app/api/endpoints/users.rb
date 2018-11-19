module Endpoints
  class Users < Grape::API
    resource :users do
      
      desc 'Login user' do
        params Entities::UsersEntity.documentation.except(:id)
        success model: Entities::UsersEntity , examples: { 'application/json' => { status: "1", message: "Login Successful", data: User.first.as_json(only: [:id, :email, :authentication_token])  } }
        failure [ { code: 422, message:  "Response message => { status: '0', message: 'Invalid email or password', data: []}"  } ]
      end
      post '/login' do
        begin
          safe_params =  clean_params(params).permit(:email, :password)
          user = User.find_by(email: safe_params[:email])
          if user && user.valid_password?(safe_params[:password]) 
            return { status:"1", message: "Login Successful", data: user.as_json(only: [:id, :email, :authentication_token])}
          else
            status 422
            return { status:'0', message: "Invalid email or password", data: []}
          end
        rescue  => e
          status 500
          return { status:'0', message: e.message, data: []}
        end
      end

      desc 'Logout user' do
        headers AuthenticationToken: {
          description: 'Validates your identity',
          required: true
        }
      end
      delete '/logout' do
        authenticate!
        return { status:"1", message: "Logout Successful", data: []}
      end
    end
  end
end