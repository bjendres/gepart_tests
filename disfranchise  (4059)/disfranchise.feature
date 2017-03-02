@api

Feature: disfranchise biased associates from voting

# while finalizing the agenda the caller may disfranchise biased associates from voting on certain ballots or elections

  Scenario Outline: disfranchising
    Given I have the role Caller
      And I am logged in and have a valid sessionId
      And the assembly is between <Time1> and <Time2>
      And I want to disfranchise an <Associate> to vote on <Item1>
    When I click disfranchising Stimmentzug on <Item1>
      And I enter part of <Associate> into Add Hinzufügen
      And I click the button search Suchen
      And I click the button Add Hinzufügen beside <Associate> on the list offered
    Then <Associate> is displayed with a button delete Entfernen besides it
      And the result is <Result>

    Examples:
      |	Time1	|	Time2	|	Associate	|	Item1	|	Result	|
      |”	DeliberationEnd	“|”	VotingStart	“|”	namexxx	“|”	Wahl-Antrag	“|”	disfranchise is stored in db and displayed with the details of the election	“|
      |”	DeliberationEnd	“|”	VotingStart	“|”	namexxx	“|”	Abstimmungs-Antrag	“|”	disfranchise is stored in db and displayed with the details of the ballot	“|
      |”	DeliberationStart	“|”	DeliberationEnd	“|”	namexxx	“|”	Abstimmungs-Antrag	“|”	error: not possible yet	“|
      |”	VotingStart	“|”	VotingEnd	“|”	namexxx	“|”	Wahl-Antrag	“|”	error: no longer possible	“|
      |”	DeliberationEnd	“|”	VotingStart	“|”		“|”	Wahl-Antrag	“|”	error: name missing	“|
      |”	DeliberationEnd	“|”	VotingStart	“|”	namexxx	“|”	Anfrage	“|”	error:not possible for Anfrage	“|
      |”	DeliberationEnd	“|”	VotingStart	“|”	namexxx	“|”	Vorschlag	“|”	error:not possible for Vorschlag	“|


      

  Scenario Outline: display disfranchised for associate

    Given I was disfranchised to vote on <Item1>
      And I am logged in and have a valid sessionId
      And the assembly is between <Time1> and <Time2>
    When I click the button vote Wählen besides <Item2>
    Then I see the <Hint>
      And the result is <Result>

    Examples:
      |”	VotingStart	“|”	VotingEnd	“|”	Wahl-Antrag nn	“|”	Wahl-Antrag nn	“|”	Dir wurde für diesen Antrag die Stimme entzogen (gemäß Satzung für Entlastungen bzw. Rechtsgeschäfte).	“|”	voting not possible, no buttons shown	“|
      |”	VotingStart	“|”	VotingEnd	“|”	Abstimmungs-Antrag nn	“|”	Abstimmungs-Antrag nn	“|”	Dir wurde für diesen Antrag die Stimme entzogen (gemäß Satzung für Entlastungen bzw. Rechtsgeschäfte).	“|”	voting not possible, no buttons shown	“|
      |”	VotingStart	“|”	VotingEnd	“|”	Wahl-Antrag nn	“|”	Wahl-Antrag nn+1	“|”		“|”	all means for voting offered	“|
      |”	VotingStart	“|”	VotingEnd	“|”	Abstimmungs-Antrag nn	“|”	Abstimmungs-Antrag mm	“|”		“|”	Droplists for all proposals offered	“|
      |”	VotingEnd 	“|”		“|”	Abstimmungs-Antrag nn	“|”	Abstimmungs-Antrag nn	“|”	Dir wurde für diesen Antrag die Stimme entzogen (gemäß Satzung für Entlastungen bzw. Rechtsgeschäfte).	“|”	okay	“|




#  Scenario: showing disfranchised in result spread sheet
# see cvs.feature



  Scenario Outline: page disfranchise Stimmentzug


    Given I have the role Caller
      And I am logged in and have a valid sessionId
    When I am on page disfranchise Stimmentzug
      And I see the <Name1> of an associate Genossenschafter
      And I see the <Button1> besides it
      And I click <Button1>
    Then <Name2> appears in <Place>
      And <Button2> is offered besides it
      And the result is <Result>


    Examples:

      |	Name1	|	Button1	|	Name2	|	Button2	|	Result	|
      |”	Musterfrau  [66] 	“|”	Hinzufügen	“|”	Musterfrau  [66] 	“|”	Entfernen	“|”	disfranchise is stored in db, stay on page	“|
      |”	Musterfrau  [66] 	“|”	Entfernen	“|”		“|”		“|”	disfranchise is deleted in db, stay on page	“|
      |”	Musterfrau  [66] 	“|”	Hinzufügen	“|”	Musterfrau  [67] 	“|”	Entfernen	“|”	error: wrong name added	“|
      |”	Musterfrau  [66] 	“|”	Entfernen	“|”	Musterfrau  [66] 	“|”	Entfernen	“|”	error: deleting in db did not work	“|

  Scenario Outline: search disfranchise

    Given I have the role Caller
      And I am logged in and have a valid sessionId
    When I am on page disfranchise Stimmentzug
      And I enter <Name1>
      And I click search Suchen
    Then I am offered a list with <Name2>, <Name3>, <Name4>
      And the result is <Result>

    Examples:
      |	Name1	|	Name2	|	Name3	|	Name4	|	Result	|
      |”	Muster	“|”	Musterfrau  [66] 	“|”	Musterfrau  [67] 	“|”	Mustermann  [65] 	“|”	correct list of names	“|
      |”	Muster	“|”	Musterfrau  [66] 	“|”	Misterfrau  [67] 	“|”		“|”	error: Name3 does ot match the pattern	“|
      |”	Mus	“|”	Muselman  [123] 	“|”	Muskelprotz  [145] 	“|”	Musterfrau  [66] 	“|”	correct list of names	“|
      |”	Musterfleck	“|”		“|”		“|”		“|”	correct: not existing	“|
      |”		“|”	Aaron	“|”	Abel	“|”	Adele	“|”	error: search name missing, all associates are listed	“|

  Scenario: search with many hits

    Given I have the role Caller
      And I am logged in and have a valid sessionId
    When I am on page disfranchise Stimmentzug
      And I enter <Name1>
      And I click search Suchen
      And there are > 10 hits
    Then I get a hint to refine my search    


