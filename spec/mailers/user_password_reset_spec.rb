require "rails_helper"

describe UserPasswordReset do
  describe "password_reset" do
    let(:user) { create_user_with_password_reset_token }
    let(:mail) { UserPasswordReset.password_reset(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Alteração da senha')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['canseidovermelho@gmail.com'])
    end
  end

end
