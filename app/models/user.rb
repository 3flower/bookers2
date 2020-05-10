class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_of_relationships, source: :user
  attachment :profile_image, destroy: false
  after_create :address
  after_create :send_thenks_mail

  # rails console JpPrefecture::Prefecture.allすると
  # @code：都道府県コード（1~47）
  # @name：都道府県名（ 漢字 ）
  # @name_e： 都道府県名（ 英語 ）
  # @name_h： 都道府県名（ ひらがな ）
  # @name_k： 都道府県名（ カナ ）
  # @zips：郵便番号
  # @area：地方区分:
  # @type：”都” or “道” or “府” or “県”

  # gem geocode使用してを住所を軽度、緯度に変換する
  # geocoded_by :address
  # after_valodation :geocode, if: :address_changed?

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true

  def follow(other_user)
    p '------------------------'
    p self.id
    p other_user.id

    if self != other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def User.search(search, user_or_book, how_search)
    if user_or_book == "users"
      if how_search == "1"
        User.where(["name LIKE ?", "#{search}"])
      elsif how_search == "2"
        User.where(["name LIKE ?", "%#{search}"])
      elsif how_search == "3"
        User.where(["name LIKE ?", "#{search}%"])
      elsif how_search == "4"
        User.where(["name LIKE ?", "%#{search}%"])
      else
        User.all
      end
    end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code, method_name: :pref  # prefecture_codeはuserが持っているカラム

  # postal_codeからprefecture_nameに変換するメソッドを用意します．
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def address
    self.address = self.prefecture_code + self.city + self.street
  end

  def send_thenks_mail
    UserMailer.user_thanks_mail(self).deliver
  end
end
