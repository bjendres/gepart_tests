Feature: Unauthorized users are not allowed to call assemblies
  An associate or moderator tries to call an assembly will fail.

  Scenario Outline: Attempt to call an assembly as unauthorized user
    Given I am logged in
      And I have the role <Role>
     When I attempt to call the pending assembly
     Then the result is <Result>

     Examples:
       | Role      | Result                        |
       | associate | error for missing permissions |
       | moderator | error for missing permissions |
