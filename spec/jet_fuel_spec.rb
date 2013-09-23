require 'spec_helper'

describe "the JetFuel app" do
  it "works" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq("the hookup")
  end
end
