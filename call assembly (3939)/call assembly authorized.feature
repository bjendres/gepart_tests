Feature: A member of the executive board or of the supervisory board defines periods, deadlines, and infos of the gathering.

  Scenario Outline: Call assembly
    Given I am logged in
      And I have the role <Role>
      And the pending assembly has not been called/persisted
      And I attempt to call the pending assembly
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
      And the assembly details are persisted for success only, including caller's role
    Examples:
      | Role       | Type          | DeliberationStart | DeliberationEnd | VotingStart | VotingEnd | GatheringDate | GatheringInfos | ProceedingsEnd | Result                                             |
      | executive  | regular       | today             | today+14        | today+15    | today+22  | today+23      | 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890 | today+37 | success |
      | supervisor | extraordinary | today             | today+15        | today+18    | today+26  | today+27      |                | today+40       | success |
      | executive  | regular       | today-1           | today+1         | today+15    | today+22  | today+23      |                | today+37       | error for past date on calling                     |
      | executive  | regular       | malformed         | 31.02.2017      | extralongxx | today+22  | today+23      |                | today+37       | errors for malformed, extralong, and invalid dates |
      | executive  | regular       | today             | today-1         | today+15    | today+22  | today+23      |                | today+37       | error for DeliberationEnd before DeliberationStart |
      | executive  | regular       | today             | today+14        | today+12    | today+22  | today+23      |                | today+37       | error for VotingStart before DeliberationEnd       |
      | executive  | regular       | today             | today+14        | today+15    | today+13  | today+23      |                | today+37       | error for VotingEnd before VotingStart             |
      | executive  | regular       | today             | today+14        | today+15    | today+22  | today+21      |                | today+37       | error for GatheringDate before VotingEnd           |
      | executive  |               | today             | today+15        | today+18    | today+26  | today+27      |                | today+40       | error for missing Type                             |
      | executive  | invalid       | today             | today+15        | today+18    | today+26  | today+27      |                | today+40       | error for invalid Type                             |
      | executive  | extraordinary |                   | today+15        | today+18    | today+26  | today+27      |                | today+40       | error for missing DeliberationStart                |
      | executive  | extraordinary | today             |                 | today+18    | today+26  | today+27      |                | today+40       | error for missing DeliberationEnd                  |
      | executive  | extraordinary | today             | today+15        |             | today+26  | today+27      |                | today+40       | error for missing VotingStart                      |
      | executive  | extraordinary | today             | today+15        | today+18    |           | today+27      |                | today+40       | error for missing VotingEnd                        |
      | executive  | extraordinary | today             | today+15        | today+18    | today+26  |               |                | today+40       | error for missing GatheringDate                    |
      | executive  | extraordinary | today;drop schema public cascade; | today+1;rm -rf / | today+18    | today+26  | non-printable UTF-8 | non-printable UTF-8 |                | errors for missing ProceedingsEnd, unallowed DeliberationStart/End, and non-printable UTF-8 characters |
      | executive  | regular       | today             | today+14        | today+15    | today+22  | today+23      | 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901 | today+37 | error for too long GatheringInfos |

  # GUI test: the automated tests must be verified manually too for visuals
  # GUI test: the screen is rendered according to the mockup (without implementation hints) on Windows Firefox, Android Chrome, and iOS Safari
  # GUI test: the html code contains all features of the mockup
  # GUI test: autofocus first (erroneous) field
  # GUI test: on submission the clicked button is disabled to prevent double click errors
  # GUI test: on error prefill provided values in the view, mark errors and show message
  # GUI test: on success redirect to agenda
  # GUI test: cancel requires a confirmation if some fields have been filled, and does not persist the assembly details

  # general:
  # GUI test: the menu links to the user account page, manual and login (while invalidating the session for logout)
  # GUI test: site is only accessible via https (with browsers' default CA store), without fall-back
  # GUI test: the http header is sent with UTF-8, without details about the server software
  # GUI test: OWASP best practice http headers are set https://www.owasp.org/index.php/List_of_useful_HTTP_headers#tab=Best_Practices
  # GUI test: the session cookie is sent HttpOnly, secure, with restricted application-path, and Strict-Transport-Security:max-age=60000;includeSubDomains
  # GUI test: the CSRF key, SSO, and DB credentials are kept secret