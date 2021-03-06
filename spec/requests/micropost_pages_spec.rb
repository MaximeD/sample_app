require 'spec_helper'

describe "Micropost Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid informations" do

      it "should not create a micropost" do
        expect { click_button "Post"}.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_error_message("error") }
      end
    end

    describe "with valid informations" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }

      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as a correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link 'delete'}.to change(Micropost, :count).by(-1)
      end
    end

    describe "as a non correct user" do
      let(:another_user) { FactoryGirl.create(:user) }
      before { visit user_path(another_user) }

      it "should not show delete links" do
        page.should_not have_link('delete')
      end
    end
  end
end
