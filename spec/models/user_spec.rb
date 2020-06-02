require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # It must be created with a password and password_confirmation fields
    it "must be created with matching password and password_confirmation fields" do
      @user = User.new(:name => "John Doe", :email => "john_doe@email.com", :password => "pass1234", :password_confirmation => "pass1234")

      expect(@user.save).to eql(true)
    end

    # These need to match so you should have an example for where they are not the same
    it "has password and password_confirmation fields not matching" do
      @user = User.new(:name => "John Doe", :email => "john_doe@email.com", :password => "pass1234", :password_confirmation => "isnot1234")

      expect(@user.save).to eql(false)
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    # These are required when creating the model so you should also have an example for this
    it "does not have one password or password_confirmation fields filled" do
      @user = User.new(:name => "John Doe", :email => "john_doe@email.com", :password => "pass1234", :password_confirmation => nil)

      expect(@user.save).to eql(false)
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    # Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)
    it "does not have case sensitivity for emails. Emails are unique. Ex: TEST@TEST.com == test@test.COM" do
      @user = User.create(:name => "John Doe", :email => "john_doe@email.com", :password => "pass1234", :password_confirmation => "pass1234")
      @user = User.new(:name => "John Doe", :email => "john_DOE@email.com", :password => "pass1234", :password_confirmation => "pass1234")

      expect(@user.save).to eql(false)
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

    # Email and name should also be required
    it "requires email and name" do
      @user = User.new(:name => nil, :email => nil, :password => "pass1234", :password_confirmation => "pass1234")

      expect(@user.save).to eql(false)
      expect(@user.errors.full_messages).to include("Name can't be blank", "Email can't be blank")
    end

    # The password must have a minimum length when a user account is being created.
    it "requires minimum length (8) for passowrds when a user account is being created" do
      @user = User.new(:name => "John Doe", :email => "john_doe@email.com", :password => "pass123", :password_confirmation => "pass123")

      expect(@user.save).to eql(false)
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "successfully fetches user when email is typed with space before and/or after" do
      @user = User.create(:name => "John Doe", :email => "john_doe@email.com", :password => "pass1234", :password_confirmation => "pass1234")
      @user.save

      expect(User.authenticate_with_credentials("  john_doe@email.com", "pass1234")).to eql(@user)
    end

    it "successfully fetches user when email is typed with different case" do
      @user = User.create(:name => "John Doe", :email => "john_doe@email.com", :password => "pass1234", :password_confirmation => "pass1234")
      @user.save

      expect(User.authenticate_with_credentials("john_DOE@email.com", "pass1234")).to eql(@user)
    end
  end
end