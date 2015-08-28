class UserPolicy < ApplicationPolicy

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

  private

    def correct_user
      @user == record
      #@user.admin? || @user == record
    end

end