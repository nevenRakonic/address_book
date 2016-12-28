require 'rails_helper'

describe 'Contact show' do
  context "User is signed in, contact with contact attributes exists" do
    let(:user) { create(:user) }
    let(:contact) { create(:contact, user: user) }
    let!(:contact_attributes) { create_list(:contact_attribute, 2, contact: contact) }

    before { login_as user, scope: :user }

    specify "she can see correct data when she visits contact show page" do
      visit contact_path(contact)
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.address)
      expect(page).to have_content(contact_attributes.first.name)
      expect(page).to have_content(contact_attributes.first.content)
      expect(page).to have_content(contact_attributes.second.name)
      expect(page).to have_content(contact_attributes.second.content)
      expect(page).to have_link 'Back', href: contacts_path
    end
  end
end
