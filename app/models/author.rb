class Author < ActiveRecord::Base

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

  def get_rating(flag)
    if flag
      return self.raiting
    else
      case self.raiting
        when 3..3.7
          return 35
        when 3.8..4.2
          return 40
        when 4.3..4.7
          return 45
        when 4.8..5
          return 50
        else
          return 50
      end
    end
  end
end