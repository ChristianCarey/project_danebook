require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user)        { build(:user) }
  let(:post)        { build_stubbed(:post) }
  let(:second_post) { build_stubbed(:post) }
  let(:third_post)  { build_stubbed(:post) }
  
  it "is valid with default attributes" do 
    expect(user).to be_valid
  end

  describe "email" do 

    it "must be unique" do 
      user.save
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
    end

  end

  describe "password" do 
    
    it "is required" do 
      expect(build(:user, password: nil)).not_to be_valid
    end

    it "must be 5 or more chars long" do 
      expect(build(:user, :short_password)).not_to be_valid
    end

    it "must match the password confirmation" do 
      expect(build(:user, :mismatched_password)).not_to be_valid
    end
  end 

  context "has many" do 

    specify "posts" do 
      expect(user).to respond_to(:posts)
    end

    specify "comments" do 
      expect(user).to respond_to(:comments)
    end

    specify "likings" do 
      expect(user).to respond_to(:likings)
    end

    specify "liked_posts" do 
      expect(user).to respond_to(:liked_posts)
    end

    specify "liked_comments" do 
      expect(user).to respond_to(:liked_comments)
    end

    specify "friendships" do 
      expect(user).to respond_to(:friendships)
    end

    specify "friends" do 
      expect(user).to respond_to(:friends)
    end

    specify "inverse_friendships" do 
      expect(user).to respond_to(:inverse_friendships)
    end

    specify "inverse_friends" do 
      expect(user).to respond_to(:inverse_friends)
    end
  end

  context "has one" do 
    specify "has one profile" do 
      expect(user).to respond_to(:profile)
    end
  end

  describe "#friend_of?" do 

    let(:other_user) { build(:user) }

    it "is true if the other user is a friend" do 
      user.friends << other_user
      expect(user.friend_of?(other_user)).to be true
    end

    it "is false if the other user is not a friend" do 
      expect(user.friend_of?(other_user)).to be false
    end
  end

  context "likables" do 
    # TODO find a way to test all 'likables' together
    let(:comment) { build_stubbed(:comment) }

    describe "#likes?" do 
  
      it "is true if the user likes the post" do 
        user.liked_posts << post
        expect(user.likes?(post)).to be true
      end

      it "is false if the user doesn't like the post" do 
        expect(user.likes?(post)).to be false
      end

      it "is true if the user likes the comment" do 
        user.liked_comments << comment
        expect(user.likes?(comment)).to be true
      end

      it "is false if the user doesn't like the comment" do 
        expect(user.likes?(comment)).to be false
      end
    end

    describe "#liked" do 

      let(:second_comment) { build_stubbed(:comment) }
      let(:third_comment)  { build_stubbed(:comment) }

      before do 
        user.liked_posts    << post
        user.liked_posts    << second_post
        user.liked_posts    << third_post
        user.liked_comments << comment
        user.liked_comments << second_comment
        user.liked_comments << third_comment
      end

      it "includes all liked_posts" do 
        expect(user.liked_posts.all? do |post|
          user.liked.include?(post)
        end).to be true
      end

      it "includes all liked_comments" do 
        expect(user.liked_comments.all? do |post|
          user.liked.include?(post)
        end).to be true
      end
    end
  end

  describe "#timeline" do 

    let(:post)        { build(:post) }
    let(:second_post) { build(:post) }
    let(:third_post)  { build(:post) }
    
    before do 
      user.posts << post
      user.posts << second_post
      user.posts << third_post
      user.save
    end

    it "orders posts by newest first" do 
      expect(user.timeline).to eq([third_post, second_post, post])
    end
  end

  context "before create" do 
  
    it "generates an auth_token" do 
      expect(user.auth_token).to be_nil
      user.save
      expect(user.auth_token).not_to be_nil
    end
  end

  context "before save" do 

    let(:uppercase_user) { build(:user, email: "FOO@BAR.COM") }

    it "downcases its email" do 
      uppercase_user.save  
      expect(uppercase_user.email).to eq("foo@bar.com")
    end
  end

  context "after create" do 

    it "creates a profile" do 
      user.save
      expect(user.profile).to be_a Profile
    end
  end
end
