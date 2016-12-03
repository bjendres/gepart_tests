Feature: A member of the assembly caller's role defines periods, deadlines, and infos of the gathering.

  Scenario: Edit assembly
    Given I am logged in
      And I have the assembly caller's role
      And I attempt to edit the pending assembly
      And a vote exist for the pending assembly
      And a support exist for the pending assembly
    When I submit the assembly id
      And I submit <Type> as Type
      And I submit <DeliberationStart> as DeliberationStart
      And I submit <DeliberationEnd> as DeliberationEnd
      And I submit <VotingStart> as VotingStart
      And I submit <VotingEnd> as VotingEnd
      And I submit <GatheringDate> as GatheringDate
      And I submit <GatheringInfos> as GatheringInfos
      And I submit <ProceedingsEnd> as ProceedingsEnd
      And I submit the session in an encrypted cookie
      And I submit the request's CSRF token
    Then the result is <Result>
      And an audit log entry is stored with user id, ip, event and result (without sensitive/malformed data)
      And the assembly details are persisted for success only
      But the vote is not modified
      And the support is not modified
    Examples:
      | Type          | DeliberationStart | DeliberationEnd | VotingStart | VotingEnd | GatheringDate | GatheringInfos | ProceedingsEnd | Result                                             |
      | regular       | today-15          | today+2         | today+5     | today+12  | today+15      | Location       | today+22       | success |

  # GUI test: the automated tests must be verified manually too for visuals
  # GUI test: the screen is rendered according to the mockup (without implementation hints) on Windows Firefox, Android Chrome, and iOS Safari
  # GUI test: the html code contains all features of the mockup
  # GUI test: autofocus first (erroneous) field
  # GUI test: on submission the clicked button is disabled to prevent double click errors
  # GUI test: prefill stored values in the view
  # GUI test: on error prefill provided values in the view, mark errors and show message
  # GUI test: on success redirect to agenda (to prevent double-posting on refresh)
  # GUI test: cancel requires a confirmation if some fields have been changed, and does not persist the assembly details
