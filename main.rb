require_relative 'inventory'

inventory = Inventory.new('db.json')

def display_menu
  puts 'Welcome to the Inventory Management System'
  puts '1- List books'
  puts '2- Add new book'
  puts '3- Remove book by ISBN'
  puts '4- Search book by ISBN'
  puts '5- Search book by title'
  puts '6- Search book by author'
  puts '0- Exit'
end

loop do
  display_menu
  print 'Please enter your choice: '
  choice = gets.chomp.to_i

  case choice
  when 1
    inventory.list_books
  when 2
    print 'Enter isbn: '
    isbn = gets.chomp.to_i
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets.chomp
    inventory.add_book(isbn, title, author)
  when 3
    print 'Enter ISBN: '
    isbn = gets.chomp.to_i
    inventory.remove_book isbn
  when 4
    print 'Enter ISBN: '
    isbn = gets.chomp.to_i
    book = inventory.search_book(isbn, 'isbn')
    if book == -1
      puts 'Book not found'
    else
      inventory.print_book book
    end
  when 5
    print 'Enter title: '
    title = gets.chomp
    book = inventory.search_book(title, 'title')
    if book == -1
      puts 'Book not found'
    else
      inventory.print_book book
    end

  when 6
    print 'Enter author: '
    author = gets.chomp
    book = inventory.search_book(author, 'author')
    if book == -1
      puts 'Book not found'
    else
      inventory.print_book book
    end

  when 0
    break
  else
    puts 'Invalid choice. Please try again.'
  end
end
