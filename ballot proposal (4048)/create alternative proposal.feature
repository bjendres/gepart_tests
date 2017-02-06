@api

# the test cases in general checks and in attachments apply here too

Feature: Any associate may post an alternative proposal for an existing ballot.

  Background: I am an associate, I am logged in 

  Scenario Outline: create an alternative proposal
    Given I am not muted
      And I clicked the button alternative proposal Alternative vorschlagen on the Agenda page or the ballot page
      And the page newproposal_ballot Vorschlag zu Abstimmungs-Antrag opened
    When I enter a title <Title>
      And I enter a description <Description>
      And I attach <Attachment>
      And I click the button <Button>
      And I answer the confirmation dialogue with <Confirm>
    Then the result is <Result>

    Examples:
      |	Title	|	Description	|	Attachment	|	Button	|	Confirm	|	Result	|
      |	“Proposal1”	|		|	“ch1.pdf”	|	“Antrag veröffentlichen”	|	“ok”	|	“the proposal is connected to the ballot, attachment added, audit log, return to agenda, agenda shows added proposal”	|
      |	“Proposal2”	|	“something”	|		|	“Antrag veröffentlichen”	|	“ok”	|	“the proposal is connected to the ballot, audit log, return to agenda, agenda shows added proposal”	|
      |	“Proposal4”	|	“something”	|		|	“Antrag veröffentlichen”	|	“Cancel”	|	“no entry into DB, return to newproposal_ballot, last entries prefilled”	|
      |		|	“anything”	|		|	“Antrag veröffentlichen”	|		|	“error: missing title, newproposal_ballot with error message and prefilled entries”	|
      |	“Proposal3”	|	“something”	|		|	“Abbrechen”	|	“Leave”	|	“nothing is saved, return to agenda”	|
      |	“Proposal2”	|	“something”	|		|	“Abbrechen”	|	“Stay”	|	“nothing is saved, return to newproposal_ballot, last entries prefilled”	|


  Scenario: muted associate
    Given I am muted
      And on page agenda
    When I try to propose an alternative to a ballot
    Then I am not allowed to

# GUI: only the button "support" is offered

      




