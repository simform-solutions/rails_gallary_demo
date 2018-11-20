ActiveAdmin.register Category do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :id, :destroy, :name

  index do
    selectable_column
    id_column
    column :name
    actions name: "Actions"
  end

  filter :name
  filter :id
end
