require 'json'
require_relative 'book'
class Inventory
  attr_accessor :books, :file_name

  def initialize(file_name)
    @file_name = file_name
    @books = get_data_from_file @file_name
  end

  def add_book(isbn, title, author)
    book = search_book(isbn, 'isbn')
    if book == -1
      book = Book.new isbn, title, author
      @books.push(book)
    else
      book['count'] += 1
    end
    sort_books
  end

  def list_books
    puts '================ All Books ==================='
    @books.each do |book|
      print_book(book)
    end
    puts '=============================================='
  end

  def print_book(book)
    puts "book ISBN: #{book['isbn']}, book title: #{book['title']}, book author: #{book['author']} book count: #{book['count']}"
  end

  def remove_book(isbn)
    @books.each do |book|
      next unless book['isbn'] == isbn

      @books.delete(book)
      sort_books
    end
  end

  def search_book(input, option)
    if @books.length > 0
      @books.each do |book|
        case option
        when 'isbn'
          return book if book['isbn'] == input
        when 'title'
          return book if book['title'] == input
        when 'author'
          return book if book['author'] == input
        else
          puts 'invalid option'
          return -1
        end
      end
    end

    -1
  end

  def sort_books
    save_data_into_file @file_name, @books
    @books = get_data_from_file @file_name
    @books = @books.sort_by { |book| book['isbn'] }
    save_data_into_file @file_name, @books
  end
end

def get_data_from_file(file_name)
  json_data = File.read(file_name)
  JSON.load(json_data)
end

def save_data_into_file(_file_name, data)
  File.open(file_name, 'w') do |file|
    file.write(JSON.pretty_generate(data))
  end
end

# inventory = Inventory.new 'db.json'
# inventory.add_book 3, 'Hala Madrid', 'Koko'
# inventory.add_book 2, 'Harry Potter', 'Hamada'
# inventory.add_book 1, 'Hala Madrid', 'Koko'

# inventory.list_books
