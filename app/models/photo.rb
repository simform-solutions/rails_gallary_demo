class Photo < ApplicationRecord
  resourcify
  belongs_to :category

  has_attached_file :attachment, :styles => {
                  :thumb => "100x100#",
                  :small  => "150x150>",
                  :medium => "200x200" },
                  :url  => "/assets/photos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"

  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 5.megabytes
  validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png']

  def attachment_url
    self.attachment.url
  end
end
