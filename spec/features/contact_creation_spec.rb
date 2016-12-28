require 'rails_helper'

describe "Contact creation" do
  context "Signed in user" do
    let(:user) { create(:user) }
    before { login_as(user, :scope => :user) }

    context "User visits the new contact page and sees the form" do
      before { visit new_contact_path }

      specify "and sees the correct form" do
        expect(page).to have_field("contact_first_name")
        expect(page).to have_field("contact_last_name")
        expect(page).to have_field("contact_address")
        expect(page).to have_field("contact_mobile_phone")
        expect(page).to have_field("contact_fixed_phone")
        expect(page).to have_field("contact_image")
        expect(page).to have_link 'Add Attribute'
      end

      context "and submits the form without added attributes correctly" do
        before do
          fill_in "contact_first_name", with: "Jack"
          fill_in "contact_last_name", with: "Example"
          fill_in "contact_address", with: "Baker Street 25"
          click_button 'Create Contact'
        end

        specify 'a flash message is shown' do
          expect(page).to have_content 'Contact succesfully created'
        end

        specify 'user is back on the updated index page' do
          expect(page).to have_content "Jack"
          expect(page).to have_content "Example"
          expect(page).to have_content "Baker Street 25"
        end
      end

      context "adds an attribute", js: :true do
        before do
          click_link 'Add Attribute'
        end

        specify 'he can see attribute form fields' do
          expect(page).to have_field("Name")
          expect(page).to have_field("Content")
        end

        context "form with contact attributes is correctly submitted" do
          before do
            fill_in "contact_first_name", with: "Jack"
            fill_in "contact_last_name", with: "Example"
            fill_in "contact_address", with: "Baker Street 25"
            fill_in "Name", with: "E-mail"
            fill_in "Content", with: "contact@example.com"
            click_button 'Create Contact'
          end

          specify 'flash message is shown' do
            expect(page).to have_content 'Contact succesfully created'
          end

          specify 'user is back on the updated index page' do
            expect(page).to have_content "Jack"
            expect(page).to have_content "Example"
            expect(page).to have_content "Baker Street 25"
          end
        end

        context "form with contact attributes is incorrectly submitted" do
          before do
            fill_in "contact_first_name", with: "Jack"
            fill_in "contact_last_name", with: "Example"
            fill_in "contact_address", with: "Baker Street 25"
            fill_in "Name", with: ""
            fill_in "Content", with: "contact@example.com"
            click_button 'Create Contact'
          end

          specify 'user is shown the validation errors' do
            expect(page).to have_content "can't be blank"
          end

          specify 'user can still see the form' do
            expect(page).to have_field("contact_first_name")
            expect(page).to have_field("contact_last_name")
            expect(page).to have_field("contact_address")
            expect(page).to have_field("contact_mobile_phone")
            expect(page).to have_field("contact_fixed_phone")
            expect(page).to have_field("contact_image")
            expect(page).to have_field("Name")
            expect(page).to have_field("Content")
            expect(page).to have_link 'Remove Attribute'
            expect(page).to have_link 'Add Attribute'
          end
        end
      end

      context "form without added attributes is submitted incorrectly" do
        before do
          fill_in "contact_address", with: "Baker Street 25"
          click_button 'Create Contact'
        end

        specify 'user is shown the validation errors' do
          expect(page).to have_content "can't be blank"
        end

        specify 'user can still see the form' do
          expect(page).to have_field("contact_first_name")
          expect(page).to have_field("contact_last_name")
          expect(page).to have_field("contact_address")
          expect(page).to have_field("contact_mobile_phone")
          expect(page).to have_field("contact_fixed_phone")
          expect(page).to have_field("contact_image")
          expect(page).to have_link 'Add Attribute'
        end
      end
    end
  end
end
