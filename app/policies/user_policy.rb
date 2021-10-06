class UserPolicy < ApplicationPolicy
  def upgrade_to_host?
    true
  end
end
