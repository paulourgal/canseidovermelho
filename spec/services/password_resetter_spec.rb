require 'rails_helper'

describe PasswordResetter do

  let(:user) { create(:user, :confirmed) }

  let(:fail_return) { { success: false, msg: "E-mail inválido." } }
  let(:success_return) do
    {
      success: true,
      msg: "E-mail enviado com as instruções para alterar a senha."
    }
  end

  it 'responds to call message' do
    expect(PasswordResetter).to respond_to(:call)
  end

  context 'when email is valid' do

    it 'sets password_reset_token password_reset_sent_at ' do
      PasswordResetter.call(user.email)
      user.reload
      expect(user.password_reset_token).not_to be_nil
    end

    it 'sets password_reset_token password_reset_sent_at ' do
      PasswordResetter.call(user.email)
      user.reload
      expect(user.password_reset_sent_at).not_to be_nil
    end

    it 'sends a confirmation email to user' do
      @instruction_mailer = double(UserPasswordReset)
      allow(UserPasswordReset).to receive(:password_reset)
        .and_return(@instruction_mailer)
      allow(@instruction_mailer).to receive(:deliver)
      expect(@instruction_mailer).to receive(:deliver)
      PasswordResetter.call(user.email)
    end

    it "returns 'success_return'" do
      expect(PasswordResetter.call(user.email)).to eq(success_return)
    end

  end

  context 'when email is invalid' do
    it "returns 'fail_return'" do
      expect(PasswordResetter.call("INVALID")).to eq(fail_return)
    end
  end

end
