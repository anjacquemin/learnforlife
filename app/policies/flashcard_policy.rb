class FlashcardPolicy < ApplicationPolicy
  def update?
    record.user == user
  end

  def results?
    record.user == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      scope.where(user: user)
    end
  end
end
