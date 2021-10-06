class HomeController < ApplicationController

  before_action :forbid_login_user, {only: [:top]}

  def top
  end

  def how_to_use
  end

  def tos
  end

  def privacyPolicy
  end

end
