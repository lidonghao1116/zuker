class HousePolicy < ApplicationPolicy
  def index?
    @user.verified?
  end
end