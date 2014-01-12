require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Blog' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:post, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:post, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
    end
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Users"
    page.should have_selector 'title', text: full_title('All users')
    click_link "Posts"
    page.should have_selector 'title', text: full_title('All posts')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "my blog"
    page.should have_selector 'title', text: full_title('')
  end
end