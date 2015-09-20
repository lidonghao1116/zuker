class UserPolicy < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new?
    create?
  end

  def create?
    @user.nil?
  end

  def edit?
    update?
  end

  def update?
    correct_user
  end

  def index?
  end

  def destroy?
    correct_user
  end

  def profile?
    correct_user
  end

  private

    def correct_user
      @user && @user == @record
      #@user.admin? || @user == record
    end

end