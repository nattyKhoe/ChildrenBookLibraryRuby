class Book
    attr_accessor :id, :title, :author, :rating, :published_date, :url, :short_description

    @@all = []

    def initialize
        @@all << self
    end

    def self.show(i)
        @@all[i-1]
    end

    def self.total
        @@all.length
    end

    def self.all
        @@all
    end

    def self.reset_all
        @@all.clear
    end

end
