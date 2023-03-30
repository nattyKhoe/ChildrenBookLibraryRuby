require 'colorize'
require_relative './scraper.rb'
require_relative './book.rb'

class Library
    @@current=true
    @@further_info=false
    # def exit
    #     puts "Thanks for using Children's Library! See you next time"
    #     exit-program
    # end

    def further_menu
        @@further_info = true
        input = nil
        input = gets.strip.downcase
       
        if input == 'exit'
            @@current = false
            puts "Thanks for using Children's Library! See you next time"
            exit-program
        elsif input == 'back'
            @@further_info = false
            self.display_menu
        elsif input.to_i.between?(1, Book.total)
            Scraper.get_further_info(input.to_i)
        else
            puts "\n Sorry, I am not sure what you are asking"
        end
    end

        

    def display_menu
        puts "Welcome to PictureBooks GoodReads Library".colorize(:color=> :blue, :mode => :bold)
        puts "Please select categories below".colorize(:light_blue)
        puts "1. Most Favourite"
        puts "2. Best Read Alouds for Young Children"
        puts "3. Most Requested"
        puts "4. Really Underated"
        puts "5. Wordless Picture Books"
        puts "Type exit to exit"
        input = gets.strip.downcase
        while @@current do
        if input == 'exit'
            @@current = false
            puts "Thanks for using Children's Library! See you next time"
            exit-program
        elsif valid_choice?(input.to_i)
            Book.reset_all
            Scraper.make_books(input.to_i-1)
            if !@@further_info
            Scraper.print_list
            end
            puts "Enter a number corresponding to gain more information \n type back to go back to main menu \n exit top exit the program"
            self.further_menu
        else
            puts "\n Sorry, I am not sure what you are asking"
        end
        end

    end

    def valid_choice?(index)
        index.between?(1,5)
    end





end
