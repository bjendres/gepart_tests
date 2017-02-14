@api

Feature: any proposal may be commented with pros Vorteile and/or cons Nachteile

  Background: valid session, assembly is before DeliberationEnd

  Scenario Outline: adding an argument
    Given I am on page <Page> 
    When I click the button Add Hinzufügen besides <Type of Argument1>
    Then the page newargument opens
      And the header is <Type of Argument2>
      And the result is <Result>

    Examples:
      | Page     | Type of Argument1  | Type of Argument2 | Result   |
      | "ballot" | "Vorteil"          | "Vorteil"         |"Success" |
      |"election"| "Nachteil"         | "Nachteil"        |"Success" |
      |"election"| "Vorteil"          | "Nachteil"        |"error: wrong type of argument displayed"|


  Scenario Outline: submitting a new argument
    Given I am on page newargument
    When I enter <Input2000>
      And click <Button>
    Then the result is <Result>

    Examples:
      |	Input2000 	|	Button	|	Result	|
      |	"argument"  	|	“ xxxxx  veröffentlichen”	|	“submit dialogue opens”	|
      |	""  	|	“ xxxxx  veröffentlichen”	|	“error: argument mandatory”	|
      |	"Nomin2000 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine200 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine200 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine400 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine600 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine800 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1000Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1200Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1400Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1600Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1800Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine2000"	|	“ xxxxx  veröffentlichen”	|	“submit dialogue opens”	|
      |	"Nomin2001 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine200 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine200 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine400 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine600 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine800 Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1000Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1200Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1400Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1600Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomine1800Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nomineexx Nominee2001"	|	“ xxxxx  veröffentlichen”	|	"error: Input2000 too long, keep input data, highlight incorrect field, stay on page”	|
      |	"<non UTF-8>"	|	“ xxxxx  veröffentlichen”	|	“error: characters not allowed, keep input data, highlight incorrect field, stay on page, log entry”	|
      |	"explanation"  	|	“Abbrechen”	|	“nothing saved to DB, return to the proposal you came from”	|


# submit.feature applies here too


  Scenario: display the new argument
    Given I entered correct data for an argument
    When I submit the argument
    Then the argument is saved in the db
      And is connected to its proposal
      And is displayed above the older arguments for this proposal

#  TC for trying to delete an argument?


