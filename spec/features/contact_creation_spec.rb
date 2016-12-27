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
      end

      context "User submits the form correctly" do
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
    end
  end
end
