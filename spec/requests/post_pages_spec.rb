require 'spec_helper'

describe "Post pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit new_post_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Create post" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Create post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
       fill_in 'post_content', with: "Lorem ipsum"
       fill_in 'post_title', with: "Lorem ipsum"
      end

      it "should create a post" do
        expect { click_button "Create post" }.to change(Post, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:post, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a post" do
        expect { click_link "delete" }.to change(Post, :count).by(-1)
      end
    end
  end
end
