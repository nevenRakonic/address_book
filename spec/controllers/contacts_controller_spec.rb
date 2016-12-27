require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  context 'signed in user' do
    let(:user) { create(:user) }
    before { sign_in user, scope: :user }

    it '#index returns 200 status' do
      get 'index'
      expect(response.status).to eq 200
    end

    it '#new returns 200 status' do
      get 'new'
      expect(response.status).to eq 200
    end

    describe '#create' do
      context 'with valid params' do
        subject { post :create, params: { contact: attributes_for(:contact) } }

        it 'returns 302 status' do
          subject
          expect(response.status).to eq 302
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
