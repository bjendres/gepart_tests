@api

Feature: conclude general assembly

  Background: submit.feature applies

  Scenario Outline: upload proceedings
# phase
# role
# file format
#  submit.feature
    
    Given I have the role <Role>
      And I am logged in and have a valid sessionId
      And the assembly is after <Time1> and before <Time2>
    When I click upload proceedings Protokoll abschließen on agenda
      And select <File> from the file system
      And click <Button>
    Then the result is <Result>

    Examples:
      |	Role	|	Time1	|	Time2	|	File	|	Button	|	Result	|
      |”	Caller	“|”	physical assembly	“|”	conclusion of assembly	“|”	proceed.pdf	“|”	submit Protokoll abschließen	“|”	proceedings in db, assembly concluded, link to proceedings on agenda, button Protokoll abschließen removed on agenda, return to where I came from, assembly listed as past on history	“|
      |”	Caller	“|”		“|”	physical assembly	“|”	proceed.pdf	“|”	submit Protokoll abschließen	“|”	error: no proceedings allowed yet	“|
      |”	Caller	“|”	physical assembly	“|”	conclusion of assembly	“|”	proceed.doc	“|”	submit Protokoll abschließen	“|”	error: only .pdf allowed	“|
      |”	Caller	“|”	physical assembly	“|”	conclusion of assembly	“|”	ch9.pdf	“|”	submit Protokoll abschließen	“|”	error: no true .pdf file (does not start with "%PDF")	“|
      |”	Caller	“|”	physical assembly	“|”	conclusion of assembly	“|”	proceed.pdf	“|”	cancel Abbrechen	“|”	no changes in db, return to agenda	“|
      |”	associate	“|”	physical assembly	“|”	conclusion of assembly	“|”	proceed.pdf	“|”	submit Protokoll abschließen	“|”	error: denied	“|
      |”	Caller	“|”	conclusion of assembly	“|”		“|”	proceed.pdf	“|”	submit Protokoll abschließen	“|”	error: not allowed any longer	“|


  Scenario: status change of assembly

    When the proceedings were uploaded
      And the link to the proceedings was added to the agenda
      And the button upload proceedings Protokoll abschließen was removed
    Then nothing can be changed for this assembly any more
      And this assembly is displayed with past assemblies Bisherige Generalversammlungen on history
      And another assembly may be called
      
