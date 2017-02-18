@api

Feature: Any associate may make an inquiry.

  Background: I am an associate, I am logged in

  Scenario Outline: create a new inquiry
    Given I am not muted
      And the assembly is before DeliberationEnd
      And I clicked the button new inquiry (Anfrage stellen) on the Agenda page
      And the page newinquiry (Anfrage) opened
    When I enter a title <Title>
      And I enter an inquiry <Inquiry>
      And I attach <Attachment>
      And I click the button <Button>
      And I answer the confirmation dialogue with <Confirm>
    Then the result is <Result>

    Examples:
      | Title  | Inquiry     | Attachment | Button | Confirm | Result |
      |"Summary1"| "Question 1"  |     "ch1.pdf"| "submit" |  "Ok"     | "inquiry is created, Attachment added, return to agenda, audit log"|
      |"Summary2"| "something"   |            | "submit" |  "Ok"     | "inquiry is created, return to agenda, audit log with user id, ip, event"|
      |"challeng"| "something"   |            | "submit" | "Cancel"  | "nothing saved, return to newinquiry" |
      |        | "anything"    |            | "submit" |         | "error: missing title, nothing saved, stay on page" |
      |"Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries Inquiries"  | "nothing" | | "submit"|  | "error: title too long, nothing saved, stay on page"|
      |"non UTF-8" |"text"       |            | "submit" |         | "error: characters not allowed, nothing saved, stay on page"|
      |"Challen"|"more than 2000 characters"| | "submit" |         | "error: inquiry too long, nothing saved, stay on page"|
      |"Challen"|              |"ch1.pdf"     | "submit" |         | "error: inquiry missing, nothing saved, stay on page"|
      |"Challen"| "Question2"    |"ch1.pdf"     |"cancel"  | "leave"   | "nothing is saved, return to agenda" |
      |"Challen"| "Question3"    |            |"cancel"  | "stay"    | "nothing is saved, return to newinquiry" |
      |"Challen"| "Question4"    |"ch1.pdf, ch2.pdf,ch3.pdf, ch4.pdf, ch5.pdf, ch6.pdf" | "submit"| |"error: too many attachments, nothing saved, stay on page"|



  Scenario: muted associate
    Given I am muted
    When I make an inquiry
    Then I am not allowed to
# GUI: only the button "support" is offered

  Scenario Outline: mapping to assembly and display
    When the inquiry was submitted correctly
      And the assembly has <ID1>
    Then the inquiry is mapped to assembly <ID2>
      And the inquiry is displayed on the agenda of assembly <ID3>
      And the result is <Result>
   Examples:
     | ID1  | ID2    | ID3    | Result  |
     | "nn" | "nn"   | "nn"   | "correct mapping"|
     | "nn" | "nn-1" | "nn-1" | "mapping error"  |
     | "nn" | "nn+1" | "nn+1" | "mapping error"  |
     | "nn" | "nn-1" | "nn"   | "mapping error"  |
      
    
    
