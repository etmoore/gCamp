require 'rails_helper'

describe AuthenticationController do
  describe '#create' do
    it 'sets the session :user_id and redirects to the projects index'
  end

  describe '#destroy' do
    it 'clears the session object and redirects to the root path'
  end
end
