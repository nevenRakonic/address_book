require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }
  describe "#create" do
    subject { post :create, params: { user: attributes_for(:user) } }
    it 'sends an extra e-mail' do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
