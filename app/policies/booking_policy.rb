class BookingPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end

  def bookings_as_owner?
    true
  end

  def destroy?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
