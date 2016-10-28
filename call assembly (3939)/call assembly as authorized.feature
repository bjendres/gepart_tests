Feature: Call assembly as authorized user
  a member of the executive board or of the supervisory board
  defines periods and deadlines and infos of the gathering

  Background:
    Given I am logged in

  Scenario: Initiate assembly call
    Given The pending assembly has not been called
     When I attempt to call the pending assembly
     Then I am required to submit Type, DeliberationStart, DeliberationEnd, VotingStart, VotingEnd, GatheringDate, GatheringInfos, ProceedingsEnd

  Scenario Outline: Submit assembly call details
    Given I have the role <Role>
      And The pending assembly has not been called
      And I attempt to call the pending assembly
     When I submit <Type> as Type
      And I submit <DeliberationStart> as DeliberationStart
      And I submit <DeliberationEnd> as DeliberationEnd
      And I submit <VotingStart> as VotingStart
      And I submit <VotingEnd> as VotingEnd
      And I submit <GatheringDate> as GatheringDate
      And I submit <GatheringInfos> as GatheringInfos
      And I submit <ProceedingsEnd> as ProceedingsEnd
     Then the result is <Result>

     Examples:
       | Role       | Type          | DeliberationStart | DeliberationEnd | VotingStart | VotingEnd | GatheringDate | GatheringInfos | ProceedingsEnd | Result                                             |
       | executive  | regular       | today             | today+14        | today+15    | today+22  | today+23      | 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890 | today+37 | successfully defined pending assembly's details with caller's UserId, Role, and ModificationTime |
       | supervisor | extraordinary | today             | today+15        | today+18    | today+26  | today+27      |                | today+40       | successfully defined pending assembly's details    |
       | executive  | regular       | today             | today-1         | today+15    | today+22  | today+23      |                | today+37       | error for DeliberationEnd before DeliberationStart |
       | executive  | regular       | today             | today+14        | today+12    | today+22  | today+23      |                | today+37       | error for VotingStart before DeliberationEnd       |
       | executive  | regular       | today             | today+14        | today+15    | today+13  | today+23      |                | today+37       | error for VotingEnd before VotingStart             |
       | executive  | regular       | today             | today+14        | today+15    | today+22  | today+21      |                | today+37       | error for GatheringDate before VotingEnd           |
       | executive  |               | today             | today+15        | today+18    | today+26  | today+27      |                | today+40       | error for missing Type                             |
       | executive  | extraordinary |                   | today+15        | today+18    | today+26  | today+27      |                | today+40       | error for missing DeliberationStart                |
       | executive  | extraordinary | today             |                 | today+18    | today+26  | today+27      |                | today+40       | error for missing DeliberationEnd                  |
       | executive  | extraordinary | today             | today+15        |             | today+26  | today+27      |                | today+40       | error for missing VotingStart                      |
       | executive  | extraordinary | today             | today+15        | today+18    |           | today+27      |                | today+40       | error for missing VotingEnd                        |
       | executive  | extraordinary | today             | today+15        | today+18    | today+26  |               |                | today+40       | error for missing GatheringDate                    |
       | executive  | extraordinary | today             | today+15        | today+18    | today+26  | today+27      |                |                | error for missing ProceedingsEnd                   |
       | executive  | regular       | today             | today+14        | today+15    | today+22  | today+23      | 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901 | today+37 | error for too long GatheringInfos |


  # GUI test: the screen is rendered according to the mockup (without implementation hints)
  # GUI test: on success redirect to assembly view, show details (also in breadcrumb), show edit assembly button for caller only
  # GUI test: on error prefill provided values in call view, mark errors and show message
  # GUI test: only dates >=today are possible (while on edit also past days may be kept/changed)
  # GUI test: submit jumps to empty required fields
  # GUI test: cancel requires a confirmation if some fields have been filled, and does not persist the assembly details
  # GUI test: infos html entities are quoted
  # GUI test: redirect to login if not logged in or session timed out
  # GUI test: CSRF token is contained in form field source
  