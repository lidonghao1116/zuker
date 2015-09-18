class RoomPolicy < ApplicationPolicy
  def new?
    @user.verified? && !@record.house.family? && @record.house.owner == @user
  end
end