class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :userimage

  def get_userimage(width, height)
    unless userimage.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      userimage.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    userimage.variant(resize_to_limit: [width, height]).processed
  end

  has_many :books, dependent: :destroy

  validates :name, length: { minimum: 2}
end
