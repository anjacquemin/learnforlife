class DuelPolicy < ApplicationPolicy
  def create?
    record.player_1 == user
  end

  def show?
    record.player_1 == user || record.player_2 == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      scope.all
    end
  end
end
