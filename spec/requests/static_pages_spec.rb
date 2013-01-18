require 'spec_helper'

describe "StaticPages", :type => :controller do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector('h1', text: "About")
    click_link "Help"
    page.should have_selector('h1', text: "Help")
    click_link "Contact"
    page.should have_selector('h1', text: "Contact")
    click_link "Home"
    page.should have_selector('h1', text: "Welcome to the Sample App")
    click_link "Sign up now!"
    page.should have_selector('h1', text: "Sign up")
    click_link "sample app"
    page.should have_selector('h1', text: "Welcome to the Sample App")
  end


  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Sample App' }

    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }

    it_should_behave_like "all static pages"
  end
  
  describe "About page" do
    before { visit about_path }
    let(:heading) { "About" }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { "Contact" }

    it_should_behave_like "all static pages"
  end

end
