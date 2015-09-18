class HousePolicy# < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user && @user.verified?
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    @user && @user.verified? && @record.owner == @user
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
    @user && @user.verified? && @record.owner == @user
  end

  # def new_comment?
  #   true
  #   # @user.verified? && record.owner != @user
  # end
end