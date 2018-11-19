module Endpoints
    class AdminUsers < Grape::API
      
      resource :admin_users do
        desc 'list'
        get do
          AdminUser.all
        end
        desc 'delete an admin'
        params do
          requires :id, type: String 
        end
        delete ':id' do
          AdminUser.find(params[:id]).destroy!
        end
      end
      end
    end