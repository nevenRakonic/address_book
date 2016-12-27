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
    end

    describe '#create' do
      context 'with valid params' do
        subject { post :create, params: { contact: attributes_for(:contact) } }

        it 'redirects to index page' do
          subject
          expect(response).to redirect_to contacts_path
        end

        it 'creates new contact' do
          expect{ subject }.to change { Contact.count }.by(1)
        end
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
