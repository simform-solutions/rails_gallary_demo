module Entities
  class UsersEntity < Grape::Entity
    expose :id, documentation: { type: String, desc: "Email Address"}
    expose :email, documentation: { type: String, desc: "Email Address",required: true}
    expose :password, documentation: { type: String, desc: "Password", required: true, param_type: 'body'}
  end
end
