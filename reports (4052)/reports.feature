@ api

#  Proposals (for elections and ballots), inqiries, answers and reports all look the same
#  the .features in general checks and in attachments apply

Feature: Executives and supervisors can file reports
  Background: 

  Scenario Outline: create answer or report
    Given I am an executive Vorstand or a supervisor Aufsichtsrat
      And I am logged in
      And I am not muted
      And the assembly is before VotingStart
      And I clicked the button <Button>
      And the page newreport Bericht opened
    When I enter a title <Title>
      And I enter a description <Description>
      And I attach <Attachment>
      And I click the button <Button>
      And I answer the confirmation dialogue with <Confirm>
    Then the result is <Result>
      
    Examples:											
          |	Button	|	Title	|	Description	|	Attachment	|	Button	|	Confirm	|	Result	|
      |	“Bericht erstellen on agenda”	|	“Report1”	|		|	“ch1.pdf”	|	“Bericht veröffentlichen”	|	“ok”	|	“the Report is saved to db and connected to the assembly, attachment added, audit log, return to agenda, agenda shows added Report”	|
      |	“Bericht erstellen on agenda”	|	“Report2”	|	“something”	|		|	“Bericht veröffentlichen”	|	“ok”	|	“the Report is saved to db and connected to the assembly, audit log, return to agenda, agenda shows added Report”	|
      |	“Bericht erstellen on agenda”	|	“Report4”	|	“something”	|		|	“Bericht veröffentlichen”	|	“Cancel”	|	“no entry into DB, return to newReport, last entries prefilled”	|
      |	“Bericht erstellen on agenda”	|		|	“anything”	|		|	“Bericht veröffentlichen”	|		|	“error: missing title, newReport with error message and prefilled entries”	|
      |	“Bericht erstellen on agenda”	|	“Report3”	|	“something”	|		|	“Abbrechen”	|	“Leave”	|	“nothing is saved, return to agenda”	|
      |	“Bericht erstellen on agenda”	|	“Report2”	|	“something”	|		|	“Abbrechen”	|	“Stay”	|	“nothing is saved, return to newReport, last entries prefilled”	|
      |	“Beantworten ”	|	“Report1”	|		|	“ch1.pdf”	|	“Bericht veröffentlichen”	|	“ok”	|	“the Report is saved to db and connected to the inquiry, attachment added, audit log, return to agenda, agenda shows added Report”	|
      |	“Beantworten ”	|	“Report2”	|	“something”	|		|	“Bericht veröffentlichen”	|	“ok”	|	“the Report is saved to db and connected to the inquiry, audit log, return to agenda, agenda shows added Report”	|
      |	“Beantworten ”	|	“Report4”	|	“something”	|		|	“Bericht veröffentlichen”	|	“Cancel”	|	“no entry into DB, return to newReport, last entries prefilled”	|
      |	“Beantworten ”	|		|	“anything”	|		|	“Bericht veröffentlichen”	|		|	“error: missing title, newReport with error message and prefilled entries”	|
      |	“Beantworten ”	|	“Report3”	|	“something”	|		|	“Abbrechen”	|	“Leave”	|	“nothing is saved, return to agenda”	|
      |	“Beantworten ”	|	“Report2”	|	“something”	|		|	“Abbrechen”	|	“Stay”	|	“nothing is saved, return to newReport, last entries prefilled”	|



  Scenario: muted 
    Given I am muted
    When I file a report
    Then I am not allowed to 
      And an audit log is written
      
  Scenario: not E 
    Given I am neither an executive Vorstand nor supervisor Aufsichtsrat
    When I file a report
    Then I am not allowed to 
      And an audit log is written
      





