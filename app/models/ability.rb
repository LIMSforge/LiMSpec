class Ability
     include CanCan::Ability


  def initialize(current_user)

   if !current_user then
     can :create, User
   else

    can :manage, UserRequirement, user_id: current_user.id

    can :manage, UserQuestion, user_id: current_user.id

    can :manage, Response
    #TODO build this out to reflect organization membership

    if  current_user.role?(:Editor)

         can :read, :all

         cannot :read, User

         can :create, Requirement

         can [:delete, :destroy, :update], Requirement, :status => 'Private', :users => {:id => current_user.id}

         can :change_selected_requirements, Requirement

         can :download_xml, Requirement

         can :getDelFile, Requirement

         can :create, Question

         can :update, Question, :status => 'Private'

         can :change_selected_questions, Question

         can :download_xml, Question

         can :getDelFile, Question


   elsif   current_user.role?(:Administrator)

           can :manage, :all

           can :approve, Requirement

           can :review, Requirement

           can :approve, Question

           can :administer, Role

           can :copy, Requirement

           can :copy, Question


    else

      can :read, :all

      can :create, User

      can :manage, User, :id => current_user.id

      can :download_xml, Requirement

      can :getDelFile, Requirement

      can :change_selected_requirements, Requirement

      can :change_industry_setting, Requirement

      can :change_selected_questions, Question

      can :change_industry_setting, Question

      can :change_selected_setting, Question

      can :download_xml, Question

      can :getDelFile, Question


    end
   end
  end
end