ActiveAdmin.register Role do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :id, :name, :destroy

  index do
    selectable_column
    id_column
    column :name  
    actions name: "Actions"
  end

  filter :name
  filter :id

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
