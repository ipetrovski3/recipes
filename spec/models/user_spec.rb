require 'rails_helper'

RSpec.describe User do
  context 'before saving' do
    it 'transforms mail to lower case' do
      igor = create(:user, mail: 'TESTER@TEST.COM')

      expect(igor.mail).to eq 'tester@test.com'
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:handle_name) }
    it { is_expected.to validate_presence_of(:mail) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to have_secure_password }

    it { is_expected.to validate_length_of(:first_name).is_at_most(30) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(30) }

    it { is_expected.to validate_length_of(:mail).is_at_most(50) }

    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  context 'mail must be unique' do
    subject { create(:user) }

    it { is_expected.to validate_uniqueness_of(:mail) }
  end

  context 'when entering invalid email format' do
    it 'is invalid' do
      igor = build(:user, mail: 'igorinvalid')

      expect(igor.valid?).to be false
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:recipes) }
    # it { expect(user.profile_image).to be_attached }
  end

  describe 'dependency' do
    let(:count) { 1 }
    let(:user) { create(:user) }

    it 'deletes recepies when user is deleted' do
      create_list(:recipe, count, user: user)

      expect { user.destroy }.to change { Recipe.count }.by(-count)
    end
  end
end
