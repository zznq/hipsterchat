require "spec_helper"

describe "hipster/index.html.erb" do
  it "should display a list of messages" do
    messages = []
    assign(:messages, 2.times { messages << FactoryGirl.create(:message) })

    render
    rendered.should have_selector("#messages .message", :count => 2)
  end
end
