@api

# the test cases in general checks and in attachments apply here too


Feature: Any associate may propose an issue for balloting.

  Background: I am an associate Genossenschafter, I am logged in 

  Scenario Outline: create a new ballot proposal Abstimmungsantrag
    Given I am not muted
      And I clicked the button newballot Abstimmung beantragen on the Agenda page 
      And the page newballot (Abstimmungs-Antrag) opened
    When I enter a title <Title>
      And I enter a description <Description>
      And I check urgency <Urgent>     # requiresExtraAssembly
      And I attach <Attachment>
      And I click the button <Button>
      And I answer the confirmation dialogue with <Confirm>
    Then the result is <Result>
      
    Examples:
      |	Title	|	Description	|	Urgent	|	Attachment	|	Button	|	Confirm	|	Result	|
      |	“Proposal1”	|		|	“checked”	|	“ch1.pdf”	|	“Antrag veröffentlichen”	|	“ok”	|	“ballot is created, the proposal is connected to the ballot, support evaluation is initiated, attachment added, audit log, return to agenda,agenda shows added ballot”	|
      |	“Proposal2”	|	“something”	|	“unchecked”	|		|	“Antrag veröffentlichen”	|	“ok”	|	“ballot is created, the proposal is connected to the ballot, audit log, return to agenda,agenda shows added ballot”	|
      |	“Proposal4”	|	“something”	|	“unchecked”	|		|	“Antrag veröffentlichen”	|	“Cancel”	|	“no entry into DB, return to newballot, last entries prefilled”	|
      |		|	“anything”	|	“checked”	|		|	“Antrag veröffentlichen”	|		|	“error: missing title, newballot with error message and prefilled entries”	|
      |	“Proposal3”	|	“something”	|	“unchecked”	|		|	“Abbrechen”	|	“Leave”	|	“nothing is saved, return to agenda”	|
      |	“Proposal2”	|	“something”	|	“unchecked”	|		|	“Abbrechen”	|	“Stay”	|	“nothing is saved, return to newballot, last entries prefilled”	|
														
														
  Scenario: muted associate
    Given I am muted
      And on page agenda
    When I try to propose a new ballot
    Then I am not allowed to

# GUI: only the button "support" is offered

  Scenario Outline: urgency
    Given I am on page newballot
    When the newest assembly has status <Status>
    Then the checkbox urgency is available <Availability>

    Examples:
      | Status  | Availability |
      |"pending"| "no"         |
      |"future" | "yes"        |
      |"past"   | "no"         |

# for a past assembly the page newballot should not be available at all



