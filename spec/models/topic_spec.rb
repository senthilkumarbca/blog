require 'rails_helper'

RSpec.describe Topic, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  it "hs a title" do
	# invalid
	t = Topic.new(title:"")
	expect(t).to_not be_valid 
	#valid
	t.title = "senthil"
	expect(t).to be_valid
  end
  
  it "has a title atleast 2 letters" do 
	#invalid
	t = Topic.new(title:"s")
	expect(t).to_not be_valid
	#valid
	t.title = "sk"
	expect(t).to be_valid
  end
  
  #it "has a title atleast 2 length" do
	#t = Topic.new(title:"ab")
	#expect(t.title.length).to be > 2
  #end
  
end


#-----------------------------

