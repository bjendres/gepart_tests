
Feature: Any associate may propose nominees for committees.

  Background: I am an associate, I am logged in 

  Scenario Outline: create a new election
    Given I am not muted
      And I clicked the button newElection (Wahl beantragen) on the Agenda page 
      And the page newelection (Wahl-Antrag) opened
    When I enter a committee <Committee>
      And I check urgency <Urgent>     # requiresExtraAssembly
      And I enter a name <Nominee> of a nominee
      And I enter a description <Description>
      And I attach <Attachment>
      And I click the button <Button>
      And I answer the confirmation dialogue with <Confirm>
    Then the result is <Result>
      
    Examples:
      |Committee| Urgent  |Nominee | Description | Attachment | Button | Confirm | Result |
      |Comm1    |checked  |Nominee1|             |  ch1.pdf   |publish |  Ok     | proposal is created, Attachment added, support evaluation initiated, return to agenda, audit log|
      |Comm200  |unchecked|Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx | something   |            |publish |  Ok     | proposal is created, return to agenda, audit log with user id, ip, event|
      |challen  |checked  |Nom     | something   |            |publish | Cancel  | nothing saved, return to newballot |
      |         |unchecked|Nom     | anything    |            |publish |         | error: missing committee, nothing saved, stay on page |
      |Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge  |checked|Nom| | |publish|  | error: committee too long, nothing saved, stay on page|
      |non UTF-8|unchecked|Nom     |             |            |publish |         | error: characters not allowed, nothing saved, stay on page|
      |ElectErr|checked   |Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx N|  |  |publish|     | error: Nominee too long, nothing saved, stay on page|
      |ElectErr|checked   |        | something   |            |publish |         | error: Nominee missing, nothing saved, stay on page|
      |ElectErr|checked   |Nom     |more than 2000 characters| |publish|         | error: description too long, nothing saved, stay on page|    
      |Challen |checked   |Nom     |             |ch1.pdf     |cancel  | leave   | nothing is saved, return to agenda |
      |Challen |checked   |Nom     |             |            |cancel  | stay    | nothing is saved, return to newelection |
      |Challen |              |ch1.pdf, ch2.pdf,ch3.pdf, ch4.pdf, ch5.pdf, ch6.pdf |publish| |error: too many attachments, nothing saved, stay on page|
  

# the following 3 Scenario Outlines are identical with the ones in ballot proposal(4048), except for the name of the pages
#
  Scenario Outline: Adding attachments   
    Given I am not muted 
      And I am on page newelection (Wahl beantragen)
      or I am on page newproposal_election (Vorschlag zu Wahl-Antrag)
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
      And I am on page newelection (Wahl beantragen)
      or I am on page newproposal_election (Vorschlag zu Wahl-Antrag)
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
      And I am on page newelection (Wahl beantragen)
      or I am on page newproposal_election (Vorschlag zu Wahl-Antrag)
      And there is at least on attachment
    When I remove 1 attachment
      And add 1 attachment
    Then the added attachment is shown beneath older attachments

  Scenario: muted associate
    Given I am muted
      And on page agenda
    When I try to propose a new election
    Then I am not allowed to            
# GUI: only the button "support" is offered

  Scenario: proposal for executive committee
    Given I try to propose an executive committee
    When I do not have the role "supervisor"
      And I entered the required items
    Then the result is denial and an audit log entry is stored with user id, ip, event 

# GUI: only supervisors are offered the button "Vorstand nominieren" (propose executive)


# GUI:  Scenario Outline: urgency
# GUI:    Given I am on page newelection
# GUI:    When the newest assembly has status <Status>
# GUI:    Then the checkbox urgency is available <Availability>

# GUI:    Examples:
# GUI:      | Status  | Availability |
# GUI:      |pending  |  no          | 
# GUI:      |future   |  yes         |
 
      
# GUI: in case of error messages, "publish>>cancel" and "cancel>>stay" all entries persist
# 



