@api

Feature: description of agenda view buttons per role and per assembly phase

  Scenario Outline: buttons per Role for a future assembly or a pending one before end of deliberation
    Given I am on page agenda Tagesordnung
      And the assembly is future or a pending one before end of deliberation
      And I have the role <Role> 
    Then I am offered the buttons <Button1>, <Button2> <Button3> for every item <Type of Item>
      And I am offered the buttons <CreateItem1>, <CreateItem2>, <CreateItem3>, <CreateItem4>, <CreateItem5> at the bottom of the page, always visible.

  Examples:
    |	Role1	|	Type of Item	|	Button1	|	Button2	|	Button3	|	CreateItem1	|	CreateItem2	|	CreateItem3	|	CreateItem4	|	CreateItem5	|
    |	“Genossenschafter”	|	“Anfrage”	|	“Unterstützen”	|	“Melden”	|		|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|		|		|
    |	“Vorstand”	|	“Anfrage”	|	“Unterstützen”	|	“Melden”	|	“Beantworten”	|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|		|	“Bericht einbringen”	|
    |	“Moderator”	|	“Anfrage”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Aufsichtsrat”	|	“Anfrage”	|	“Unterstützen”	|	“Melden”	|	“Beantworten”	|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|	“Vorstand nominieren”	|	“Bericht einbringen”	|
    |		|		|		|		|		|		|		|		|		|		|
    |	“Genossenschafter”	|	“Antrag”	|	“Alternative vorschlagen”	|		|		|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|		|		|
    |	“Vorstand”	|	“Antrag”	|	“Alternative vorschlagen”	|		|		|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|		|	“Bericht einbringen”	|
    |	“Moderator”	|	“Antrag”	|		|		|		|		|		|		|		|		|
    |	“Aufsichtsrat”	|	“Antrag”	|	“Alternative vorschlagen”	|		|		|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|	“Vorstand nominieren”	|	“Bericht einbringen”	|
    |	“Genossenschafter”	|	“Bericht”	|		|	“Melden”	|		|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|		|		|
    |	“Vorstand”	|	“Bericht”	|		|	“Melden”	|		|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|		|	“Bericht einbringen”	|
    |	“Moderator”	|	“Bericht”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Aufsichtsrat”	|	“Bericht”	|		|	“Melden”	|		|	“Abstimmung beantragen” 	|	“Wahl beantragen”	|	“Anfrage stellen”	|	“Vorstand nominieren”	|	“Bericht einbringen”	|




  Scenario Outline: buttons per Role for an assembly between end of deliberation and VotingStart, during finalizing agenda
    Given I am on page agenda Tagesordnung
      And the assembly is between DeliberationEnd and VotingStart
      And I have the role <Role> 
    Then I am offered the buttons <Button1>, <Button2> <Button3> for every item <Type of Item>
      And I am offered the buttons <CreateItem1>, <CreateItem2>, <CreateItem3>, <CreateItem4>, <CreateItem5> at the bottom of the page, always visible.

  Examples:
    |	Role	|	Type of Item	|	Button1	|	Button2	|	Button3	|	CreateItem1	|	CreateItem2	|	CreateItem3	|	CreateItem4	|	CreateItem5	|
    |"Caller"	|	“Anfrage”	|	“Beantworten”	|	“Melden”	|		|		|		|		|		|	“Bericht einbringen”	|
    |"Caller"	|	“Antrag”	|	“Stimmentzug”	|		|		|		|		|		|		|	“Bericht einbringen”	|
    |"Caller"	|	“Vorschlag”	|	“Zulassung entziehen”	|	“Zulassen”	|		|		|		|		|		|	“Bericht einbringen”	|
    |	“Genossenschafter”	|	“Anfrage”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Genossenschafter”	|	“Antrag”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Genossenschafter”	|	“Vorschlag”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Vorstand”	|	“Anfrage”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Vorstand”	|	“Antrag”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Vorstand”	|	“Vorschlag”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Aufsichtsrat”	|	“Anfrage”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Aufsichtsrat”	|	“Antrag”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Aufsichtsrat”	|	“Vorschlag”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Moderator”	|	“Anfrage”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Moderator”	|	“Antrag”	|		|	“Melden”	|		|		|		|		|		|		|
    |	“Moderator”	|	“Vorschlag”	|		|	“Melden”	|		|		|		|		|		|		|



  Scenario Outline: buttons per Role for an assembly during voting
    Given I am on page agenda Tagesordnung
      And the assembly is between VotingStart and VotingEnd
      And I have the role <Role> 
    Then I am offered the buttons <Button1> for every item <Type of Item>
      And I see the number of supporters for each proposal
      And I see whether I voted already.
  Examples:
    |	Role	|	Type of Item	|	Button1	|
    |	“Genossenschafter”	|	“Abstimmungs-Antrag”	|	“Abstimmen”	|
    |	“Vorstand”	|	“Abstimmungs-Antrag”	|		|
    |	“Moderator”	|	“Abstimmungs-Antrag”	|		|
    |	“Aufsichtsrat”	|	“Abstimmungs-Antrag”	|		|
    |	“Genossenschafter”	|	“Bericht”	|		|
    |	“Vorstand”	|	“Bericht”	|		|
    |	“Moderator”	|	“Bericht”	|		|
    |	“Aufsichtsrat”	|	“Bericht”	|		|
    |	“Genossenschafter”	|	“Wahl-Antrag”	|	“Wählen”	|
    |	“Vorstand”	|	“Wahl-Antrag”	|		|
    |	“Moderator”	|	“Wahl-Antrag”	|		|
    |	“Aufsichtsrat”	|	“Wahl-Antrag”	|		|



Scenario: buttons per Role for an assembly between VotingEnd and ProceedingsEnd
    Given I am on page agenda Tagesordnung
      And the assembly is between VotingEnd and ProceedingsEnd
      And I have the role of the Caller 
    Then I am offered the button "Protokoll abschließen"
      
   
