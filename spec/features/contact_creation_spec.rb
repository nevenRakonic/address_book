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

      context "User submits the form without added attributes correctly" do
        before do
          fill_in "contact_first_name", with: "Jack"
          fill_in "contact_last_name", with: "Example"
          fill_in "contact_address", with: "Baker Street 25"
          click_button 'Create Contact'
        end

        specify 'User is shown the flash message' do
          expect(page).to have_content 'Contact succesfully created'
        end

        specify 'User is back on the updated index page' do
          expect(page).to have_content "Jack"
          expect(page).to have_content "Example"
          expect(page).to have_content "Baker Street 25"
        end
      end

      context "User adds an attribute", js: :true do
        before do
          click_button 'Add Attribute'
        end

        specify 'User can see attribute form fields' do
          expect(page).to have_field(/contact_contact_attributes_attributes_*_name/)
          expect(page).to have_field(/contact_contact_attributes_attributes_*_content/)
        end
      end

      context "User submits the form without added attributes incorrectly" do
        before do
          fill_in "contact_address", with: "Baker Street 25"
          click_button 'Create Contact'
        end

        specify 'User is shown the validation errors' do
          expect(page).to have_content "can't be blank"
        end

        specify 'User can still see the form' do
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
