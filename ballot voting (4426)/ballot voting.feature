@api

# alle bewerten
# Widerstand begründen
# beliebig zu ändern während Stimmabgabe
# bei Fristverschiebung bleiben votes erhalten, aber ev. wieder verdeckt
# beim 1. Mal alle "Widerstand auswählen"
# danach der bisher gewählte Widerstand


Feature: voting on ballot proposals

# text syntax checks.feature applies


  Background: associates rate every proposal of a ballot to find the one with the least resistance against. 

  Scenario Outline: select restistance against all proposals
    Given I am an associate
      And I have a valid sessionId
      And I am not disfranchised for the ballot
      And the assembly is between VotingStart and VotingEnd
      And there are <Number of Proposals1> for a ballot
    When I open the details for this ballot
      And <Number of Proposals2> of this ballot have a resistance Widerstandswert selected
      And I click <Button>
    Then <Result>

    Examples:
      |	Number of Proposals1	|	Number of Proposals2	|	Button	|	Result	|
      |”	2	“|”	2	“|”	Stimme abgeben	“|”	the votes are saved to the db, return to where I came from	“|
      |”	1	“|”	1	“|”	Stimme abgeben	“|”	error: at least 2 proposals needed (1 new, 1 status quo)	“|
      |”	4	“|”	3	“|”	Stimme abgeben	“|”	error:all proposals need to ranked	“|
      |”	5	“|”	6	“|”	Stimme abgeben	“|”	error: not so many proposals	“|
      |”	3	“|”	3	“|”	Abbrechen	“|”	nothing saved, return to where I came from	“|



   Scenario Outline: strong resistance
    Given I am an associate
      And I have a valid sessionId
      And I am not disfranchised for the ballot
      And the assembly is between VotingStart and VotingEnd
    When I select <Resistance> for a proposal
      And I enter <Argument> for that proposal
      And I chose my resistance against all proposals
      And I click <Button>
    Then <Result>

    Examples:
      |	Resistance	|	Argument	|	Button	|	Result	|
      |”	2	“|”	thats why	“|”	Stimme abgeben	“|”	votes and argument saved, reurn to where I came from	“|
      |”	1	“|”	because	“|”	Stimme abgeben	“|”	votes and argument saved, reurn to where I came from	“|
      |”	1	“|”		“|”	Stimme abgeben	“|”	votes and argument saved, reurn to where I came from	“|
      |”	2	“|”		“|”	Stimme abgeben	“|”	error: argument necessary for strong resistance	“|
      |”	2	“|”	argument	“|”	Abbrechen	“|”	nothing saved, return to where I came from	“|


  Scenario Outline: prefill

# 1st time or already voted

    Given I am an associate
      And I have a valid sessionId
      And I am not disfranchised for the ballot
      And the assembly is between VotingStart and VotingEnd
    When I vote for the <Ordinal> time
    Then the resistances against all proposals are prefilled with <Prefill>
      And <Result>

    Examples:
      |	Ordinal	|	Prefill	|	Result	|
      |”	first	“|”	Widerstandswert wählen	“|”	okay	“|
      |”	second	“|”	resistances already saved	“|”	okay	“|
      |”	first	“|”	0 to 2	“|”	error: wrong prefill	“|
      |”	second	“|”	Widerstandswert wählen	“|”	error: votes lost	“|




# log file see submit.feature

#  Scenario: disfranchised see 4059

