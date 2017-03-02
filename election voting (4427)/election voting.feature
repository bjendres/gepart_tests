@api

Feature: sort candidates by preference

  Background: I am logged in with valid sessionID, I am an associate

# Schwelle
# alle gereiht
# stimme entzogen
# Zustand abhängig von schon gestimmt
# submit
# Funktion der Pfeile
# drag & drop
# Reihungszahl eingeben

  Scenario Outline: rank all candidates
    Given I am an associate
      And I have a valid sessionId
      And I am not disfranchised for the election
      And the assembly is between VotingStart and VotingEnd
      And there are <Number of Proposals1> for this election
    When I open the details of this election
      And <Number of proposals2> have a rank Reihungszahl
      And I click <Button>
    Then <Result>

    Examples:
      |	Number of Proposals1	|	Number of Proposals2	|	Button	|	Result	|
      |”	2	“|”	2	“|”	Stimme abgeben	“|”	votes saved, return to where I came from	“|
      |”	3	“|”	2	“|”	Stimme abgeben	“|”	error: all candidates must be ranked	“|
      |”	3	“|”	4	“|”	Stimme abgeben	“|”	error: too many ranks	“|
      |”	1	“|”	1	“|”	Stimme abgeben	“|”	error: at least 2 choices (1 candidate + status quo)	“|
      |”	6	“|”	6	“|”	Abbrechen	“|”	nothing saved, return to where I came from	“|


  Scenario Outline: prefill

    Given I am an associate
      And I have a valid sessionId
      And I am not disfranchised for the election
      And the assembly is between VotingStart and VotingEnd
    When I vote for the <Ordinal> time
    Then the ranks of all candidates are prefilled with <Prefill>
      And <Result>

    Examples:
      |	Ordinal	|	Prefill	|	Result	|
      |”	first	“|”	Reihungszahl wählen	“|”	okay	“|
      |”	second	“|”	saved ranks	“|”	okay	“|
      |”	first	“|”	any ranks	“|”	error: no ranks yet	“|
      |”	second	“|”	Reihungszahl wählen	“|”	error: ranking lost	“|

#  Scenario Outline: handling the ranking

