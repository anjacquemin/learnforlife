class QuizzLevelPolicy < ApplicationPolicy
  def show?
    record.quizz_level_progresses.find_by(user: user).unlocked
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
