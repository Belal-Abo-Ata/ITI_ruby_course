require 'json'
class Inventory
  @@isbn = 1
  @@books = []

  def self.add_book(title, author)
    book = { isbn: @@isbn, title: title, author: author }
    @@isbn += 1
    @@books.push(book)
    File.open('db.json', 'w') do |file|
      file.write(JSON.pretty_generate(@@books))
    end
  end

  def self.list_books
    for book in @@books
      puts "book ISBN: #{book[:isbn]}, book title: #{book[:title]}, book author: #{book[:author]}"
    end
  end

  def self.remove_book(isbn)
    for book in @@books
      next unless book[:isbn] == isbn

      @@books.delete(book)
      File.open('db.json', 'w') do |file|
        file.write(JSON.pretty_generate(@@books))
      end
    end
  end
end

# Inventory.add_book 'Harry Potter', 'Hamada'
# Inventory.add_book 'Hala Madrid', 'Koko'
# Inventory.add_book 'Hala Madrid', 'Koko'
# Inventory.list_books

def display_menu
  puts 'Welcome to the Inventory Management System'
  puts '1- List books'
  puts '2- Add new book'
  puts '3- Remove book by ISBN'
  puts '0- Exit'
end

loop do
  display_menu
  print 'Please enter your choice: '
  choice = gets.chomp.to_i

  case choice
  when 1
    puts 'All books'
    Inventory.list_books
  when 2
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets.chomp
    Inventory.add_book(title, author)
  when 3
    print 'Enter ISBN: '
    isbn = gets.chomp.to_i
    Inventory.remove_book isbn
  when 0
    break
  else
    puts 'Invalid choice. Please try again.'
  end
end
