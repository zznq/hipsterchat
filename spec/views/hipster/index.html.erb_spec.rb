require "spec_helper"

describe "hipster/index.html.erb" do
  it "should display a list of messages" do
    assign(:messages, Array.new(2) { FactoryGirl.build_stubbed(:message) })

    render
    rendered.should have_selector("#messages .message", :count => 2)
  end
end
