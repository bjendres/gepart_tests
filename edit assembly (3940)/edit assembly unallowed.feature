Feature: Unallowed assembly editing is denied.

  Scenario Outline: Attempt to edit an assembly as unauthorized user
    Given I am logged in
      And I do not have the assembly caller's role
    When I attempt to edit the pending assembly
    Then the result is an error for missing permissions
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  # GUI test: in case of an error the assembly history is shown, except for an invalid session the user is redirected login screen
  # GUI test: no general error details or stack trace is shown
