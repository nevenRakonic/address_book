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
  end

  context 'user that is not signed in' do
    it '#index returns 304 status' do
      get 'index'
      expect(response.status).to eq 302
    end
  end
end
