class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

#  validates :poster_image_url,
 #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    return 0 if reviews.empty?
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  mount_uploader :image, ImageUploader

#  def upload_over_url
#    if image.present?
#      image.url(:thumb)
#    else
#      poster_image_url
#    end
#  end

protected

#  def one_form_of_image_required
#    if !image.present? && !poster_image_url.present?
#      errors.add(:image, "Please upload an image or provide an image url")
#    end
#  end

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
