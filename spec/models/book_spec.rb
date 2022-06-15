require 'rails_helper'

RSpec.describe Book, :type => :model do
  subject {
    described_class.new(title: "Anything",
                        description: "Lorem ipsum",
                        author: "sam")
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a author" do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:category).without_validating_presence }
  end
  

end