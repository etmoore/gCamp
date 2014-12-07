class MarketingController < ApplicationController
  skip_before_action :require_signin
end
