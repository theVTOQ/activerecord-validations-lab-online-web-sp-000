class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :clickbait?

  def clickbait?
    phrases = ["Won't Believe", "Secret", "Guess"]
    conforms = title_contains_one_of_these_phrases?(phrases) || title =~/(Top )[\d]/
    if !conforms
      error_message = "must exist, and must contain at least one of these phrases: \"" + phrases.join("\", \"")
      errors.add(:title, error_message + ", or Top [number]")
    end
  end

  def title_contains_one_of_these_phrases?(phrases)
    #binding.pry
    return false if title == nil
    phrases.each {|phrase| return true if title.include?(phrase)}
    false
  end
end
