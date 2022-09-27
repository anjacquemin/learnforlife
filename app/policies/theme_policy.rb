class ThemePolicy < ApplicationPolicy
  def show?
    # no access to quizzs from adventure theme
    !record.adventure_only
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
