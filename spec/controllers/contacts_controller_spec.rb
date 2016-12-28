require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  context 'signed in user and a contact exist' do
    let(:user) { create(:user) }
    let!(:contact) { create(:contact, user: user) }
    before { sign_in user, scope: :user }

    it '#index returns 200 status' do
      get :index
      expect(response.status).to eq 200
    end

    it '#new returns 200 status' do
      get :new
      expect(response.status).to eq 200
    end

    it "#show returns 200 status" do
      get :show, params: { id: contact.id }
      expect(response.status).to eq 200
    end

    it "#edit returns 200 status" do
      get :edit, params: { id: contact.id }
      expect(response.status).to eq 200
    end

    describe '#destroy' do
      subject { delete :destroy, params: { id: contact.id } }

      it 'destroys a contact that belongs to the user' do
        expect{ subject }.to change{ Contact.count }.by(-1)
      end

      it 'redirects to index page' do
        subject
        expect(response).to redirect_to contacts_path
      end

      context "with other users contact params" do
        let!(:other_user) { create(:user) }
        let!(:other_contact) { create(:contact, user: other_user) }

        subject { delete :destroy, params: {
            id: other_contact.id
          }
        }

        it 'raises an error' do
          expect{ subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe '#create' do
      context 'with valid params including 2 contact attributes' do
        subject { post :create, params:
          {
            contact: attributes_for(:contact).merge!(
            contact_attributes_attributes: {
              "0" => attributes_for(:contact_attribute),
              "1" => attributes_for(:contact_attribute)
            }),
          }
        }

        it 'redirects to contacts index' do
          subject
          expect(response).to redirect_to contacts_path
        end

        it 'creates new contact' do
          expect{ subject }.to change { Contact.count }.by(1)
        end

        it 'creates two new contact attributes' do
          expect{ subject }.to change { ContactAttribute.count }.by(2)
        end
      end

      context 'with invalid params' do
        subject { post :create, params:
          {
            contact: { first_name: "" }
          }
        }

        it 'returns 200 response' do
          subject
          expect(response.status).to eq 200
        end

        it 'does not create new contact' do
          expect{ subject }.to_not change { Contact.count }
        end

        it 'does not create new contact attribute' do
          expect{ subject }.to_not change { ContactAttribute.count }
        end
      end
    end

    describe '#update' do
      context 'with valid params including 2 contact attributes of which one has destroy param' do
        let!(:contact_attributes) { create_list(:contact_attribute, 2, contact: contact) }
        subject { put :update, params:
          {
            id: contact.id,
            contact: { first_name: "Updated Contact Name" }.merge!(
            contact_attributes_attributes: {
              "0" => { name: "Updated Attribute", content: "New Content", id: contact_attributes.first.id },
              "1" => { id: contact_attributes.second.id, _destroy: "1" }
            }),
          }
        }

        it 'redirects to contacts index' do
          subject
          expect(response).to redirect_to contacts_path
        end

        it "updates the contact" do
          subject
          expect(contact.reload.first_name).to eq "Updated Contact Name"
        end

        it 'updates the correct contact attribute' do
          subject
          expect(contact_attributes.first.reload.name).to eq "Updated Attribute"
          expect(contact_attributes.first.reload.content).to eq "New Content"
        end

        it 'deletes a contact attribute' do
          expect{ subject }.to change { ContactAttribute.count }.by(-1)
        end
      end

      context 'with invalid params' do
        subject { put :update, params:
          {
            id: contact.id,
            contact: { first_name: "" }
          }
        }

        it 'returns 200 response' do
          subject
          expect(response.status).to eq 200
        end

        it 'does not update contact' do
          subject
          expect(contact.reload.first_name).to eq contact.first_name
        end

        it 'does not create new contact attributes' do
          expect{ subject }.to_not change { ContactAttribute.count }
        end
      end
    end

    context "with other users contact params" do
      let!(:other_user) { create(:user) }
      let!(:other_contact) { create(:contact, user: other_user) }

      subject { put :update, params: {
          id: other_contact.id,
          contact: { first_name: "New Name" }
        }
      }

      it 'raises an error' do
        expect{ subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'user that is not signed in' do
    it '#index returns 302 status' do
      get 'index'
      expect(response.status).to eq 302
    end
  end
end
