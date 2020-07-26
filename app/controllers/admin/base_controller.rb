class Admin::BaseController < ApplicationController
  before_action :verify_admin

  private

  def verify_admin
    redirect_to r