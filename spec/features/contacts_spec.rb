describe "Contacts spec" do
  context "User is signed in and two contacts belonging to them exist" do
    let(:user) { create(:user) }
    let!(:first_contact) { create(:contact, user: user) }
    let!(:second_contact) { create(:contact, first_name: "James", user: user) }

    before { login_as(user, scope: :user) }
    specify "He sees correct information on the index page" do
      visit contacts_path
      expect(page).to have_content first_contact.first_name
      expect(page).to have_content second_contact.first_name
      expect(page).to have_link 'Show', href: contact_path(first_contact)
      expect(page).to have_link 'Show', href: contact_path(second_contact)
      expect(page).to have_link 'Edit', href: edit_contact_path(first_contact)
      expect(page).to have_link 'Edit', href: edit_contact_path(second_contact)
      expect(page).to have_link 'Delete', href: contact_path(first_contact)
      expect(page).to have_link 'Delete', href: contact_path(second_contact)

      expect(page).to have_link 'New', href: new_contact_path
    end
  end
end
