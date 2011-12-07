# Class from which all controller which requires users to be
# authenticated for use will inherit.
class AuthenticatedUserController < ApplicationController
  before_filter :authenticate!
end
