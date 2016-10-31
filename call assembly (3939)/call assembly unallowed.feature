Feature: Unallowed assembly calls are denied.

  Scenario Outline: Attempt to call an assembly as unauthorized user
    Given I am logged in
      And I have the role <Role>
      And I have no role executive nor supervisor
    When I attempt to call the pending assembly
    Then the result is <Result>
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated
    Examples:
      | Role      | Result                        |
      | associate | error for missing permissions |
      | moderator | error for missing permissions |

  Scenario: Attempt to call a future assembly while the pending assembly is ongoing
    Given I am logged in
      And I have the role executive
      And the pending assembly is between deliberation end and proceedings end
    When I attempt to call the future assembly
    Then the result is error for invalid assembly id
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly without session
    Given my last interaction within the login session is 10 minutes past
      And I have the role executive
      And the pending assembly has not been called
    When I attempt to call the pending assembly
    Then the result is error for invalid session
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with invalid session
    Given I have the role executive
      And the pending assembly has not been called
    When I attempt to call the assembly with wrong session cookie (wrong encrypted session id)
    Then the result is error for invalid session
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with wrong CSRF token
    Given I am logged in
      And I have the role executive
      And the pending assembly has not been called
    When I attempt to call the assembly with wrong CSRF token
    Then the result is error for invalid session
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with unsupported method
    Given I am logged in
      And I have the role executive
      And the pending assembly has not been called
    When I attempt to call the assembly with PUT
    Then the result is error for unsupported method
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with missing/invalid id
    Given I am logged in
      And I have the role executive
      And the pending assembly has not been called
    When I attempt to call the assembly with invalid id
    Then the result is error for invalid assembly id
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with unaccessible database
    Given I am logged in
      And I have the role executive
      And the database is unaccessible
    When I attempt to call the pending assembly
    Then the result is a general error
      And the error details are logged
      But no assembly details are updated

  # GUI test: in case of an error the assembly history is shown, except for an invalid session the login screen is shown
  # GUI test: no general error details or stack trace is shown
