require 'rails_helper'

RSpec.describe "topics/index", type: :view do
  before(:each) do
    assign(:topics, [
      Topic.create!(title:"topic1"),
      Topic.create!(title:"topic2")
    ])
  end

  it "renders a list of topics" do
    render
  end
end
