require 'rails_helper'

RSpec.describe Profile, type: :model do
 
  let(:profile) { build(:profile) } 

  it "is valid with default values" do 
    expect(profile).to be_valid
  end

  context "belongs to" do 
    
    specify "user" do 
      expect(profile).to respond_to(:user)
    end
  end
end
