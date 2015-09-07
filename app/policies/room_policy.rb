class RoomPolicy < ApplicationPolicy
  def new?
    @user.verified? && !record.house.family?
  end
end