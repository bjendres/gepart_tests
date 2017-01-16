@api
Feature: Unallowed assembly calls are denied.

  Scenario Outline: Attempt to call an assembly as unauthorized user
    Given I am logged in as a role <Role>
      And I have no role Vorstand nor Aufsichtsrat
    When I attempt to call the pending assembly
    Then the result is <Result>
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated
    Examples:
      | Role      | Result                        |
      | Genossenschafter | "error for missing permissions" |
      | Moderator | "error for missing permissions" |

  Scenario: Attempt to call a future assembly while the pending assembly is ongoing
    Given I am logged in as a role Vorstand
      And there is a pending assembly
    When I attempt to call the future assembly
    Then the result is "error for invalid assembly id"
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly without session
    Given my last interaction within the login session is "10" minutes past
      And I have the role Vorstand
      And the future assembly has not been called
    When I attempt to call the future assembly
    Then the result is "error for invalid session"
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with invalid session
    Given I am logged in as a role Vorstand
      And the future assembly has not been called
    When I attempt to call the assembly with wrong session cookie wrong encrypted session id
    Then the result is "error for invalid session"
      And an audit log entry is stored with user id, ip, event and error without sensitive or malformed data
      But no assembly details are updated

  Scenario: Attempt to call an assembly with wrong CSRF token
    Given I am logged in as a role Vorstand
      And the future assembly has not been called
    When I attempt to call the assembly with wrong CSRF token
    Then the result is "error for invalid session"
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with unsupported method
    Given I am logged in as a role Vorstand
      And the future assembly has not been called
    When I attempt to call the assembly with PUT
    Then the result is "error for unsupported method"
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with missing/invalid id
    Given I am logged in as a role Vorstand
      And the future assembly has not been called
    When I attempt to call the assembly with invalid id
    Then the result is "error for invalid assembly id"
      And an audit log entry is stored with user id, ip, event and error (without sensitive/malformed data)
      But no assembly details are updated

  Scenario: Attempt to call an assembly with unaccessible database
    Given I am logged in as a role Vorstand
      And the database is unaccessible
    When I attempt to call the future assembly
    Then the result is "general error"
      And the error details are logged
      But no assembly details are updated

#   # GUI test: in case of an error the assembly history is shown, except for an invalid session the user is redirected to login screen
#   # GUI test: no general error details or stack trace is shown
