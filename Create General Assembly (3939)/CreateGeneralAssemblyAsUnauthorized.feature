Feature: Unauthorized Users are not allowed to create General Assemblies
  A common member or moderator tries to create a General Assembly, but fails.

  Scenario: attempt to create General Assembly as Unauthorized user
    Given I am logged in
      And I do not have the role Vorstand or Aufsichtsrat
     When I attempt to create a General Assembly
     Then the result is an error
