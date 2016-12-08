
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
      |Comm1    |checked  |Nominee1|             |  ch1.pdf   | submit |  Ok     | proposal is created, Attachment added, support evaluation initiated, return to agenda, audit log|
      |Comm200  |unchecked|Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx | something   |            | submit |  Ok     | proposal is created, return to agenda, audit log with user id, ip, event|
      |challen  |checked  |Nom     | something   |            | submit | Cancel  | nothing saved, return to newballot |
      |         |unchecked|Nom     | anything    |            | submit |         | error: missing committee, nothing saved, stay on page |
      |Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge  |checked|Nom| | | submit |  | error: committee too long, nothing saved, stay on page|
      |non UTF-8|unchecked|Nom     |             |            | submit |         | error: characters not allowed, nothing saved, stay on page|
      |ElectErr|checked   |Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx N|  |  | submit |     | error: Nominee too long, nothing saved, stay on page|
      |ElectErr|checked   |        | something   |            | submit |         | error: Nominee missing, nothing saved, stay on page|
      |ElectErr|checked   |Nom     |more than 2000 characters| | submit |         | error: description too long, nothing saved, stay on page|    
      |Challen |checked   |Nom     |             |ch1.pdf     |cancel  | leave   | nothing is saved, return to agenda |
      |Challen |checked   |Nom     |             |            |cancel  | stay    | nothing is saved, return to newelection |
      |Challen |              |ch1.pdf, ch2.pdf,ch3.pdf, ch4.pdf, ch5.pdf, ch6.pdf |publish| |error: too many attachments, nothing saved, stay on page|
  


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



