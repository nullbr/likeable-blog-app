class Post < ApplicationRecord
  belongs_to :user

  has_many :ratings, dependent: :destroy

  validates :title, :body, presence: true
  validates :ip, presence: true,
                 format: { with: /\A(?:\d{1,3}\.){3}\d{1,3}\z/, message: "must be a valid IPv4 address" }, if: :ipv4?
  validate :valid_ip_format

  def average_rating
    ratings.average(:value).to_f
  end

  private

  def valid_ip_format
    return if ip =~ /\A(?:\d{1,3}\.){3}\d{1,3}\z/ || ip =~ /\A([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}\z/

    errors.add(:ip, "must be a valid IP address (IPv4 or IPv6)")
  end

  def ipv4?
    ip =~ /\A(?:\d{1,3}\.){3}\d{1,3}\z/
  end
end
