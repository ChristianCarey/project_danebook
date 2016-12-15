require 'rails_helper'

describe PostPresenter do 

  before do 
    def presenter.current_user 
    end

    allow(presenter).to receive(:current_user).and_return(user)
  end

  let(:presenter) { PostPresenter.new(post, view) }
  let(:post) { create(:post) }
  let(:user) { create(:user) }

  describe "#first_and_other_likers" do 

    context "no likers" do 
      it "returns nil" do 
        expect(presenter.first_and_other_likers).to be_nil
      end
    end

    context "one liker" do 
      
      before do 
        user.like(post)
      end

      it "displays the liker" do 
        expect(presenter.first_and_other_likers).to include("#{user.name}")
      end
    end

    context "several likers" do 

      let(:second_user) { create(:user) }
      let(:third_user) { create(:user) }

      before do 
        user.like(post)
        second_user.like(post)
        third_user.like(post)
      end

      it "displays the first liker" do 
        expect(presenter.first_and_other_likers).to include(post.likers.first.name)
      end

      it "displays number of remaining likers" do 
        expect(presenter.first_and_other_likers).to include((post.likers.size - 1).to_s)
      end
    end
  end

  describe "#num_likings" do 

    context "no likers" do 
      it "returns nil" do 
        expect(presenter.num_likings).to be_nil
      end
    end

    context "several likers" do 

      let(:second_user) { create(:user) }
      let(:third_user) { create(:user) }

      before do 
        user.like(post)
        second_user.like(post)
        third_user.like(post)
      end

      it "displays number of likers" do 
        expect(presenter.num_likings).to include((post.likers.size).to_s)
      end
    end
  end

  describe "#like_link" do 

    context "user already likes post" do 

      before do 
        user.like(post)
      end

      it "shows and unlike option" do 
        expect(presenter.like_link).to include("Unlike")
      end
    end

    context "user doesn't like post" do 

      it "shows a like option" do 
        expect(presenter.like_link).to include("Like")
      end
    end
  end

  describe "#delete_link" do 
    
    context "current user's post" do 

      before do 
        post.author = user
        post.save
      end

      it "shows a delete link" do 
        expect(presenter.delete_link).to include("Delete")
      end
    end

    context "someone else's post" do 

      it "shows nothing" do 
        expect(presenter.delete_link).to be_nil
      end
    end
  end
end