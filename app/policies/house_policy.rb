class HousePolicy < ApplicationPolicy
  def index?
    @user.verified?
  end

  def new?
    create?
  end

  def create?
    @user.verified? && record.owner == @user
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

  def rooms?
    update?
  end

  def update?
    @user.verified? && record.owner == @user
  end

  def new_comment?
    @user.verified? && record.owner != @user
  end
end