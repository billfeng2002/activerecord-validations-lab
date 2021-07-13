class Post < ActiveRecord::Base
    validates :title, presence: :true
    validates :content, length: {minimum:250}
    validates :summary, length: {maximum:250}
    validates :category, inclusion: {in: ["Fiction", "Non-Fiction"] }
    validate :clickbait

    def clickbait
        baits=["Won't Believe", "Secret", /Top \d/, "Guess"]
        baits.each{|bait|
            break if !title
            if(bait.class==Regexp)
                return if title.match(bait)
            end
            if(bait.class==String)
                return if title.include?(bait)
            end
        }
        errors[:clickbait]="Not Clickbaity enough"
    end
end
