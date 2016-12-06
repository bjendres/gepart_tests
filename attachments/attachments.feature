Feature: add and delete attachments 

# this attachment handling is valid throughout this application 

  Background: I am an associate, I am logged in, I am not muted 

  Scenario Outline: Adding attachments
    Given I want to add an attachment
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
    Given I want to delete an attachment
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
    Given there is at least on attachment
    When I remove 1 attachment
      And add 1 attachment
Then the added attachment is shown beneath older attachments
