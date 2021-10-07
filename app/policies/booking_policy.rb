class BookingPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    record.user_id == user.id
  end

  def bookings_as_owner?
    true
  end

  def destroy?
    true
  end

  def index?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
