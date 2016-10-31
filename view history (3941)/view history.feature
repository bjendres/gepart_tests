Feature: Any known/active user can view the list of pending, future, and past assemblies.

  Scenario Outline: View assembly history
    Given I am logged in
      And I have the role <Role>
    When I attempt to view the pending assembly
    Then I see the assembly history
    Examples:
      | Role       |
      | associate  |
      | supervisor |
      | executive  |
      | moderator  |

  Scenario: Attempt to call an assembly without session
    Given I am not logged in
    When I attempt to view the pending assembly
    Then the result is error for invalid session
     And the login page is shown

  # GUI test: the screen is rendered according to the mockup (without implementation hints) on Windows Firefox, Android Chrome, and iOS Safari
  # GUI test: the html code contains all features of the mockup
  # GUI test: the pending assembly is shown first, then the future assembly (if already created, once the pending assembly ended deliberation), then the past ones sorted by descending id
  # GUI test: the type/date of assemblies is shown, if unavailable only the assembly id
  # GUI test: gathering and contribution infos are shown with encoded html characters
  # GUI test: the caller's role is shown
  # GUI test: pagination for every 10 assemblies
  # GUI test: the call button for the uncalled pending assembly is only provided to supervisors or executives
  # GUI test: the edit button for the called pending assembly is only provided to the users with the assembly caller's role
  # GUI test: the moderation button is provided for moderators
  # GUI test: the precedings button for the pending assembly after voting phase is only provided to the users with the assembly caller's role
  # GUI test: on submission the clicked button is disabled to prevent double click errors
  # GUI test: available precedings are linked for assemblies, with filename of the gatherering date
  # GUI test: the menu links to the user account page, manual and login (while invalidating the session for logout)
