class DuelQuizzPolicy < ApplicationPolicy
  def create?
    record.duel.player_1 == user || record.duel.player_2 == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all

  end
end
