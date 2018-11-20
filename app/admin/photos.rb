ActiveAdmin.register Photo do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :id, :category_id, :attachment, :destroy
  
  index do
    selectable_column
    id_column
    column :category
    column "Attachment" do |attachment|
        span do
          image_tag(attachment.attachment.url(:thumb),size: "50x50")
        end
    end
    actions name: "Actions"
  end

  filter :category
  filter :id

  form do |f|
    f.inputs do
      f.input :category
      f.input :attachment
    end
    f.actions
  end

  show do |f|
    attributes_table do
      row :category
      row :attachment do
        image_tag f.attachment.url(:small), size: "50x50"
      end
      row :created_at
      row :updated_at
    end
   end
end
