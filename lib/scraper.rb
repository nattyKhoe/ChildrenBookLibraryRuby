require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './book.rb'

class Scraper

    @@links = ["1961.Best_Childhood_Picture_Books", 
    "591.Voices_Sounds_Best_Read_Alouds_for_Young_Children", 
    "742.What_Again_Most_requested_Children_s_books", 
    "18860.Really_Underrated_Children_s_Books",
    "722.Wordless_Picture_Books"]
    
    def self.get_further_info(index)
        book = Book.show(index)
        data = Nokogiri::HTML(URI.open('https://www.goodreads.com' + book.url))
        book.published_date = data.css('p[data-testid="publicationInfo"]').text
        book.short_description = data.css('.DetailsLayoutRightParagraph__widthConstrained').first.children.text
        puts "ID: #{book.id}"
        puts "Title: #{book.title}"
        puts "Author: #{book.author}"
        puts "Rating: #{book.rating}"
        puts book.published_date
        puts "Synopsis: #{book.short_description}"
        puts ''
        puts '---------------------------------'
    end

    def self.make_books(input)
        link = @@links[input]
        books = Nokogiri::HTML(URI.open("https://www.goodreads.com/list/show/" + link)).css('tr')
        books.each_with_index do |row, index|
            book = Book.new
            book.id = index + 1
            book.url = row.css('.bookTitle').first['href']
            book.title = row.css('.bookTitle').css('span').text
            book.author = row.css('.authorName').text
            book.rating = row.css('.minirating').text
        end
    end

    def self.print_list
        Book.all.each do |book|
            if book.title
                puts "ID: #{book.id}"
                puts "Title: #{book.title}"
                puts "Author: #{book.author}"
                puts "Rating: #{book.rating}"
                # puts book.url
                # puts book.published_date
                # puts "Synopsis: #{book.short_description}"
                puts "----------------------------------------------------------"
            end
        end
    end
end


