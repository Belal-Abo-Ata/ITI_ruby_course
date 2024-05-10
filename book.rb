require 'json'
class Book
  attr_accessor :isbn, :title, :author, :count

  def initialize(isbn, title, author, count = 1)
    @isbn = isbn
    @title = title
    @author = author
    @count = count
  end

  def as_json
    {
      'isbn': @isbn,
      'title': @title,
      'author': @author,
      'count': @count
    }
  end

  def to_json(*_args)
    as_json.to_json
  end
end
