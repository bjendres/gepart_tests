

Feature: Any associate may post an alternative proposal for an existing election.
#
# this is identical with create alternative proposal.feature in ballot proposal (4048), where Title == Nominee

  Background: I am an associate, I am logged in 

  Scenario Outline: create an alternative proposal
    Given I am not muted
      And I clicked the button alternative proposal (Alternative vorschlagen) on the Agenda page or the election page
      And the page newproposal_election (Vorschlag zu Wahl-Antrag) opened
    When I enter a nominee <Title>
      And I enter a description <Description>
      And I attach <Attachment>
      And I click the button <Button>
      And I answer the confirmation dialogue with <Confirm>
    Then the result is <Result>

    Examples:
      | Title  | Description | Attachment | Button | Confirm | Result |
      |Proposal|             | attach1.pdf| submit |  Ok     | proposal is created, Attachment added, support evaluation initiated, return to agenda, an audit log entry is stored with user id, ip, event |
      |challeng| something   |            | submit |  Ok     | proposal is created, return to agenda, an audit log entry is stored with user id, ip, event  |
      |challeng| something   |            | submit | Cancel  | nothing saved, return to newballot |
      |        | anything    |            | submit |         | error: missing title, nothing saved, stay on page |
      |Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge Challenge  | | | submit |  | error: title too long, nothing saved, stay on page|
      |non UTF-8|            |            | submit |         | error: characters not allowed, nothing saved, stay on page|
      |Challen|more than 2000 characters| | submit |         | error: description too long, nothing saved, stay on page|    
      |Challen|              |ch1.pdf     |cancel  | leave   | nothing is saved, return to agenda |
      |Challen|              |            |cancel  | stay    | nothing is saved, return to newballot |
      |Challen|              |ch1.pdf, ch2.pdf,ch3.pdf, ch4.pdf, ch5.pdf, ch6.pdf |publish| |error: too many attachments, nothing saved, stay on page|
  

  Scenario Outline: alternative executive proposal
    Given I make an alternative election proposal
    When my role is <Role>
      And the committee is "executive"
    Then the result is <Result>
    Examples:
    | Role      | Result |
    |supervisor | proposal is accepted, and an audit log entry is stored with user id, ip, event|
    |not supervisor| denial, and an audit log entry is stored with user id, ip, event

# GUI: Button "Alternative vorschlagen" for election of executives is offered only to supervisors
      




