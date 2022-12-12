# frozen_string_literal: true

class AfterLoginApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_logged_in

  private
    def set_logged_in
      @user = current_user
      @user_signed_in = user_signed_in?
    end
end
