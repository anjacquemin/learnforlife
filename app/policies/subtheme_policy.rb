class SubthemePolicy < ApplicationPolicy
  def show?
    record.subtheme_progresses.find_by(user: user).unlocked
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
