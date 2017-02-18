@api

Feature: all the checks for each submit

# a very general description
# purpose: reminder that the security checks are necessary for every single submit

Background: I am on any of the pages newballot Abstimmungs-Antrag, newproposal_ballot Vorschlag zu Abstimmungs-Antrag, newelection Wahl-Antrag,
  newproposal_election Vorschlag zu Wahl-Antrag, newinquiry Anfrage,
  newreport Bericht, ballot_voting Abstimmungs-Antrag nnn, election_voting Wahl-Antrag nnn
  
  Scenario: security features with correct content
    Given the content is formally correct
    When I submit the page 
      And I changed some content
      And I have the necessary permission
      And I submit the session id in an encrypted cookie
      And I submit the request's CSRF token
      And I answer the confirmation dialogue with "OK"
    Then the submit button is disabled to prevent double clicks
      And an audit log is stored with user id, ip, event and result without sensitive data
      And the content is stored to the DB
      And I am stored as the author of the contribution
      And I return to where I have been before I got to the page I submitted

# this is not accurate, because the submit button should be disabled immediately after being clicked
# but I cannot describe it because nested "When" is not allowed 

  Scenario: submit of incorrect data
    Given the content is formally incorrect
    When I submit the page
    Then an error message is shown
      And the data in the page stay as before 
      And the incorrect data are highlighted and selected




