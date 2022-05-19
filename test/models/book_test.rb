require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(title: "Example Book", description: "This is a book", author: "James Bond")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "name should be present" do
    @book.title = "    "
    assert_not @book.title?
  end

  test "Saved" do
    assert @book.save
  end

  test "destroy" do
    assert @book.destroy
  end
end
