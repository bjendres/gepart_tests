@api
Feature: add and delete attachments 

# this attachment adding and deleting handling is valid throughout this application 
# pages: Abstimmungs-Antrag newballot, Vorschlag zu Abstimmungs-Antrag newproposal_ballot,  Anfrage newinquiry,
# Bericht newreport and newanswer,

  Background: I am a Genossenschafter or Vorstand or Aufsichtsrat, I am logged in, I am not muted 

  Scenario Outline: Adding attachments
    Given I am on any of the above listed pages
    When there are already the number of attachments <no attachments>
      And I select the file <File> from the file system
      And I click the button Hinzufügen Add
    Then the result is <Result>

    Examples:
      |no attachments| File        | Result |
      |   "0 "       | "ch1.pdf"   |"ch1.pdf is shown with a delete-button to the right, a new select box is offered" | 
      |   "4"        | "ch5.pdf"   |"ch5.pdf is shown beneath the other attachments, all with a corresponding delete-button, but no new select box"|
      |   "1"        | "ch8.pdf"   |"error: attachment too big" |
      |   "3"        | "ch7.doc"   |"error: only .pdf files allowed"|
      |   "5"        | "ch6.pdf"   |"error: more than 5 attachments" |
      |   "2"        | "ch9.pdf"   |"error: no true .pdf file (does not start with "%PDF")"|
      |   "1"        | "ch10 this filename is too long and should be shortened automatically to 50 characters, including the .pdf" | "a shortened filename is shown with a delete-button to the right, a new select box is offered" | 


  Scenario Outline: removing attachments
    Given I am on any of the above listed pages
    When there are already a number of attachments <no attachments>
      And I click the button Entfernen delete in line <Line> of the list of attachments
    Then the result is <Result>

    Examples:
      |no attachments  | Line   | Result |
      |     "1"        |  "1"   |"empty list of attachments, box to select an attachment "|
      |     "3"        |  "2"   |"2 attachments ordered by ID, box to select an attachment below "|
      |     "0"        |  "1"   |" error: nothing to delete "|                     # in the GUI there should not be a button to click   
      |     "5"        |        |"list of 5 attachments, no box to select an attachment" |


  Scenario: adding and removing attachments
    Given I am on any of the above listed pages
      And there is at least one attachment
    When I remove 1 attachment
      And add 1 attachment
    Then the added attachment is shown beneath older attachments
    
  Scenario: file not existing
    Given I am on any of the above listed pages
      And there is 1 attachment
    When I enter " a non-existing file" as attachment name
    Then this is refused because the file does not exist
