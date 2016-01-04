describe User do
  let!(:user) do
    User.create(email: 'blah@blah.com', password: 'blahblahblah', password_confirmation: 'blahblahblah')
  end

  describe '#generate_token' do
    it "saves a password recovery token when a token is generated" do
      expect{user.generate_token}.to change{user.password_token}
    end

    it "saves a password recovery token time when a token is generated" do
      Timecop.freeze do
        user.generate_token
        expect(user.password_token_time).to eq Time.now
      end
    end

    describe '#find_by_valid_token' do
      it 'finds a user with a valid token' do
        user.generate_token
        expect(User.find_by_valid_token(user.password_token)).to eq user
      end

      it "can't find a user with token over 1 hour old" do
        user.generate_token
        Timecop.travel(60*60+1) do
          expect(User.find_by_valid_token(user.password_token)).to eq nil
        end
      end
    end
  end
end
