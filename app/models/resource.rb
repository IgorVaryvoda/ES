class Resource < ActiveRecord::Base
  belongs_to :order

  has_attached_file :document
  do_not_validate_attachment_file_type :document
  validates_attachment :document, :size => {:in => 0..5.megabytes}, :content_type => { :content_type => ["image/jpeg", "image/png", "text/plain", "image/gif", "image/pjpeg", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/msword", "application/vnd.ms-excel", "application/pdf", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"] }

end