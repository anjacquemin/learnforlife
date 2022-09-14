class ApplicationController < ActionController::Base
  require 'will_paginate/array'

  before_action :first_time_visit

  before_action :store_user_location!, if: :storable_location?
  # The callback which stores the current location must be added before you authenticate the user
  # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect
  # before the location can be stored.

  before_action :authenticate_user!
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

    def first_time_visit
      session[:display_indication] ||= {}
      session[:display_indication][controller_name] ||= {}
      if session[:display_indication][controller_name][params[:action]]
        session[:display_indication][controller_name][params[:action]] += 1
      else
        session[:display_indication][controller_name][params[:action]] = 1
      end
      @display_indication = (session[:display_indication][controller_name][params[:action]] == 1)
    end


    def skip_pundit?
      devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    end

    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end

end
