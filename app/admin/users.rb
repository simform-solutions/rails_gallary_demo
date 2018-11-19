ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :id, :email, :password, :password_confirmation, :role_ids => []

  index do
    selectable_column
    id_column
    column :email
    column "Roles" do |user|
      span do
        user.roles.map(&:name).to_s
      end
    end   
    actions
  end

  filter :roles
  filter :id
  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles
    end
    f.actions
  end

  show do |f|
    attributes_table do
      row :email
      row :roles do
        user.roles.map(&:name).to_s
      end
      row :created_at
      row :updated_at
      row :authentication_token
    end
   end

end
