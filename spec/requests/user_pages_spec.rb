require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "profile page" do
    # create user variable
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

  describe "signup page" do   
    before { visit signup_path }

    it { should have_selector('h1',    text: "Sign up") }
    it { should have_selector('title', text: 'Sign up') }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid informations" do

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end

      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid informations" do
      before { fill_with_valid_infos }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email("user@example.com") }

        it { should have_selector('title', text: user.name) }
        it { should have_success_message('Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1',     text: "Update your profile") }
      it { should have_selector('title',  text: "Edit user") }
      it { should have_link('change',     href: "http://gravatar.com/emails") }
    end

    describe "with invalid informations" do
      before { click_button "Save changes" }

      it { should have_error_message("error") }
      # it { should have_content('error') }
    end

    describe "with valid informations" do
      let(:new_name)  { "New name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_success_message("Profile updated") }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
