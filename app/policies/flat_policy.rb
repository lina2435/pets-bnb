class FlatPolicy < ApplicationPolicy

  def show?
    true  # Anyone can view a restaurant
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
