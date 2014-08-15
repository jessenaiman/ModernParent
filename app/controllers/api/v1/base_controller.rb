class Api::V1::BaseController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  
private

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
