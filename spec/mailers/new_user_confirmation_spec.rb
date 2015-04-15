require "rails_helper"

describe NewUserConfirmation do
  context 'user_confirmation' do
    let(:user) { create(:user) }
    let(:mail) { NewUserConfirmation.user_confirmation(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Confirmação de cadastro')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['canseidovermelho@gmail.com'])
    end
  end
end
