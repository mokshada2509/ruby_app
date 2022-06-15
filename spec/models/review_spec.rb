require 'rails_helper'

RSpec.describe Review, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  subject {
    described_class.new(rating: 5, comment: "Anything")
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a rating" do
    subject.rating = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a comment" do
    subject.comment = nil
    expect(subject).to_not be_valid
  end
end
