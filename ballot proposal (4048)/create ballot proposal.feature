
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
      |Proposal|             | checked | ch1.pdf    | submit|  Ok     | proposal is created, Attachment added, support evaluation initiated, return to agenda, audit log|
      |challeng| something   |unchecked|            | submit |  Ok     | proposal is created, return to agenda, audit log with user id, ip, event|
      |challeng| something   |unchecked|            | submit | Cancel  | nothing saved, return to newballot |
      |        | anything    | checked |            | submit |         | error: missing title, nothing saved, stay on page |
      |Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge  | |unchecked | |submit|  | error: title too long, nothing saved, stay on page|
      |non UTF-8 |           | checked |            | submit |         | error: characters not allowed, nothing saved, stay on page|
      |Challen|more than 2000 characters|unchecked| | submit |         | error: description too long, nothing saved, stay on page|    
      |Challen|              |unchecked|ch1.pdf     |cancel  | leave   | nothing is saved, return to agenda |
      |Challen|              |unchecked|            |cancel  | stay    | nothing is saved, return to newballot |
      |Challen|              |unchecked|ch1.pdf, ch2.pdf,ch3.pdf, ch4.pdf, ch5.pdf, ch6.pdf |publish| |error: too many attachments, nothing saved, stay on page|
  

  Scenario: muted associate
    Given I am muted
      And on page agenda
    When I try to propose a new ballot
    Then I am not allowed to            
# GUI: only the button "support" is offered

# GUI:  Scenario Outline: urgency
# GUI:     Given I am on page newballot
# GUI:     When the newest assembly has status <Status>
# GUI:     Then the checkbox urgency is available <Availability>
# GUI: 
# GUI:     Examples:
# GUI:       | Status  | Availability |
# GUI:       |pending  |  no          | 
# GUI:       |future   |  yes         |

      




