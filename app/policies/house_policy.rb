class HousePolicy < ApplicationPolicy
  def index?
    @user.verified?
  end

  def new?
    @user.verified?
  end

  def edit?
    update?
  end

  def basic?
    update?
  end

  def amenity?
    update?
  end

  def description?
    update?
  end

  def space?
    update?
  end

  def photo?
    update?
  end

  def date_status?
    update?
  end

  def update?
    @user.verified? && record.owner == @user
  end
end