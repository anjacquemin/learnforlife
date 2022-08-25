class ApplicationController < ActionController::Base
  require 'will_paginate/array'

  before_action :authenticate_user!
end
