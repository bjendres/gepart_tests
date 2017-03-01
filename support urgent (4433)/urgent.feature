@api

Feature: support for urgent ballots or elections

  Scenario Outline: evaluation of support for urgent items

    Given the assembly has not been called yet
      And I am an associate
      And I am logged in
      And I have a valid sessionId
      And an <Item1> is marked as urgent by the creator
      And the supporters for any proposal to <Item1> are summed up in SUM
      And I have <Number1> of proposals already supported
    When I <Support> <Number2> of proposals connected to <Item1>
      And SUM plus  <ADD> equals <Comparator> 3*(square root (number of voters), rounded down to int)
    Then <Action> is initiated
    And support for the proposals is saved to db

    Examples:
      |	Item1	|	Number1	|	Support	|	Number2	|	ADD	|	Comparator	 |	Action	|
      |”	ballot	“|”	1	“|”	support	“|”	1	“|”	0	“|”	<	“|”	none	“|
      |”	election	“|”	2	“|”	withdraw support	“|”	1	“|”	0	“|”	<	“|”	none	“|
      |”	ballot	“|”	1	“|”	withdraw support	“|”	1	“|”	-1	“|”	<	“|”	none	“|
      |”	election	“|”	0	“|”	support	“|”	1	“|”	1	“|”	=	“|”	Mail to all executives and supervisors + badge on agenda	“|
      |”	ballot	“|”	0	“|”	support	“|”	5	“|”	1	“|”	=	“|”	Mail to all executives and supervisors + badge on agenda	“|
      |”	inquiry	“|”	1	“|”		“|”		“|”		“|”		“|”	error: only ballots and elections can be urgent	“|
      |”	proposal	“|”	1	“|”		“|”		“|”		“|”		“|”	error: only ballots and elections can be urgent	“|
      |”	ballot	“|”	3	“|”	withdraw support	“|”	3	“|”	-1	“|”	=	“|”	none; mail already sent	“|
      |”	election	“|”	0	“|”	support	“|”	2	“|”	1	“|”	>	“|”	none; mail already sent	“|
      |”	ballot	“|”	4	“|”	withdraw support	“|”	4	“|”	-1	“|”	>	“|”	none; mail already sent	“|


 
# threshold for support: 3*(square root (number of voters), rounded down to int)
# before calling
# for each urgent ballot or election the number of supporters are calculated, independent of the number of proposals they support
# the author of a proposal is always considered as a supporter





