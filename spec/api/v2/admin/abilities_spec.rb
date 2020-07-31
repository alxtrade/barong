# encoding: UTF-8
# frozen_string_literal: true

describe API::V2::Admin::Abilities, type: :request do
  let!(:create_admin_permission) do
      create :permission,
             role: 'admin'
  end
  let(:admin) { create(:user, :admin, :level_3, email: 'example@gmail.com', uid: 'ID73BF61C8H0') }
  let(:token) { jwt_for(admin) }

  describe 'GET /api/v2/admin/abilities' do
    it 'get all roles and permissions' do
      get '/api/v2/admin/abilities', token: token
      result = JSON.parse(response.body)

      expect(response).to be_successful
      expect(result['roles'].count).to eq 7
      expect(result['roles']).to eq ['admin', 'manager', 'accountant', 'superadmin', 'technical', 'compliance', 'support']
    end
  end
end