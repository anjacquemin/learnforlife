class UserAnswerPolicy < ApplicationPolicy
  def create?
    record.quizz_answer.user == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
