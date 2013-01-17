require 'spec_helper'

describe "StaticPages", :type => :controller do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', :text => "Sample App") }

    # it "should have the title 'Home'" do
    #   page.should have_selector('title',
    #                             :text => "Ruby on Rails Tutorial Sample App | Home")
    # end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1', :text => "Help") }

    # it "should have the title 'Help'" do
    #   visit '/static_pages/help'
    #   page.should have_selector('title',
    #                             :text => "Ruby on Rails Tutorial Sample App | Help")
    # end
  end
  
  describe "About page" do
    before { visit about_path }
    
    it { should have_selector('h1', :text => 'About Us') }

    # it "should have the title 'About Us'" do
    #   visit '/static_pages/about'
    #   page.should have_selector('title',
    #                             :text => "Ruby on Rails Tutorial Sample App | About Us")
    # end
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1', :text => 'Contact') }
  end

end
