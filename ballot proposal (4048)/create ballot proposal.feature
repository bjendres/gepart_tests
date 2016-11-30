
Feature: Any associate may propose an issue for balloting.

  Background: I am an associate, I am logged in 

  Scenario Outline: create a new proposal
    Given I am not muted
      And I clicked the button newballot (Abstimmung beantragen) on the Agenda page 
      And the page newballot (Abstimmungs-Antrag) opened
    When I enter a title <Title>
      And I enter a description <Description>
      And I check urgency <Urgent>     # requiresExtraAssembly
      And I attach <Attachment>
      And I click the button <Button>
      And I answer the confirmation dialogue with <Confirm>
    Then the result is <Result>
      
    Examples:
      | Title  | Description | Urgent  | Attachment | Button | Confirm | Result |
      |Proposal|             | checked | attach1.pdf|publish |  Ok     | proposal is created, Attachment added, support evaluation initiated, return to agenda, audit log|
      |challeng| something   |unchecked|            |publish |  Ok     | proposal is created, return to agenda, audit log with user id, ip, event|
      |challeng| something   |unchecked|            |publish | Cancel  | nothing saved, return to newballot |
      |        | anything    | checked |            |publish |         | error: missing title, nothing saved, stay on page |
      |Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge  | |unchecked | |publish|  | error: title too long, nothing saved, stay on page|
      |non UTF-8 |           | checked |            |publish |         | error: characters not allowed, nothing saved, stay on page|
      |Challen|more than 2000 characters|unchecked| |publish |         | error: description too long, nothing saved, stay on page|    
      |Challen|              |unchecked|ch1.pdf     |cancel  | leave   | nothing is saved, return to agenda |
      |Challen|              |unchecked|            |cancel  | stay    | nothing is saved, return to newballot |
      |Challen|              |unchecked|ch1.pdf, ch2.pdf,ch3.pdf, ch4.pdf, ch5.pdf, ch6.pdf |publish| |error: too many attachments, nothing saved, stay on page|
  


  Scenario Outline: Adding attachments
    Given I am not muted 
      And I am on page newballot (Abstimmung beantragen)
      or I am on page newproposal_ballot (Vorschlag zu Abstimmungs-Antrag)
    When there are already the number of attachments <no attachments>
      And I select the file <File> from the file system
      And I click the button Add (Hinzufügen) 
    Then the result is <Result>

    Examples:
      |no attachments| File      | Result |
      |   0          | ch1.pdf   |ch1.pdf is shown with a delete-button to the right, a new select box is offered | 
      |   4          | ch5.pdf   |ch5.pdf is shown beneath the other attachments, all with a corresponding delete-button, but no new select box|
      |   1          | ch8.pdf   |error: attachment too big |
      |   3          | ch7.doc   |error: only .pdf files allowed
      |   5          | ch6.pdf   |error: more than 5 attachments |


  Scenario Outline: removing attachments
    Given I am not muted
      And I am on page newballot (Abstimmung beantragen)
      or I am on page newproposal_ballot (Vorschlag zu Abstimmungs-Antrag)
    When there are already a number of attachments <no attachments>
      And I click the button delete (Entfernen) in line <Line> of the list of attachments
    Then the result is <Result>

    Examples:
      |no attachments| Line | Result |
      |     1        |  1   |empty list of attachments, box to select an attachment |
      |     3        |  2   |2 attachments ordered by ID, box to select an attachment below |
      |     0        |  1   | error: nothing to delete |                     # in the GUI there should not be a button to click   
      |     5        |      | list of 5 attachments, no box to select an attachment |


  Scenario: adding and removing attachments
    Given I am on page newballot (Abstimmung beantragen)
      or I am on page newproposal_ballot (Vorschlag zu Abstimmungs-Antrag)
      And there is at least on attachment
    When I remove 1 attachment
      And add 1 attachment
    Then the added attachment is shown beneath older attachments

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
      |pending  |  no          | 
      |future   |  yes         |

      




