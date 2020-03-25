class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: %w(Fiction Non-Fiction), message: "%{value} is not a valid category"}

  validate :is_title_sufficently_clickbaity?

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top [1-5]*/i,
    /Guess/i
  ]

  def is_title_sufficently_clickbaity?
    if CLICKBAIT_PATTERNS.none? {|pattern| pattern.match title}
      errors.add(:title, "must be more clickbaity")
    end
  end
end
