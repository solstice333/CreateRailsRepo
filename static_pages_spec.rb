require 'spec_helper'

describe "StaticPages" do
   let(:baseTitle) { "Ruby on Rails Tutorial Sample App" } 

   describe "Home page" do
      it "should have the content 'Sample App'" do 
         visit root_path
         expect(page).to have_content('Sample App')
      end

      it "should have the right title 'Ruby on Rails Tutorial Sample App'" do
         visit root_path
         expect(page).to have_title("#{baseTitle}")
         expect(page).not_to have_title(" | Home")
      end
   end

   describe "Help page" do
      it "should have the content 'Help'" do
         visit help_path
         expect(page).to have_content('Help')
         expect(page).to have_content('Get help on the Ruby on Rails')
      end

      it "should have the right title 'Help'" do
         visit help_path
         expect(page).to have_title("#{baseTitle}")
         expect(page).to have_title(" | Help")
      end
   end

   describe "About page" do
      it "should have the content 'About us'" do
         visit about_path
         expect(page).to have_content('About us')
      end

      it "should have the right title 'About us'" do
         visit about_path
         expect(page).to have_title("#{baseTitle}")
         expect(page).to have_title(" | About us")
      end
   end

   describe "Contact page" do
      it "should have the content 'Contact' and title 'Contact'" do
         visit contact_path
         expect(page).to have_content("Contact")
      end

      it "should have the title 'Contact'" do
         visit contact_path
         expect(page).to have_title("#{baseTitle}")
         expect(page).to have_title(" | Contact")
      end
   end

end
