class Claim < ActiveRecord::Base
	belongs_to :user
    validates :upload, :attachment_presence => true

    has_attached_file :upload, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/
end
