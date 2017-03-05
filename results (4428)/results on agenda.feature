@api

Feature: show results on agenda

  Background: the assembly is past VotingEnd and before physical assembly

# admitted proposals sorted by resistance, lowest first
# rank only for winning proposal(s)
# disregarded proposals follow, sorted by supports descending
# hidden proposals last, visible only for supporters, sorted by supports descending

  Scenario Outline: ballot results on agenda

    Given a ballot with proposals <Prop1> having status <Stat1> and resistance <Res1> and support <Sup1>
      And <Prop2> having status <Stat2> and resistance <Res2> and support <Sup2>
      And <Prop3> having status <Stat3> and resistance <Res3> and support <Sup3>
      And <Prop4> having status <Stat4> and resistance <Res4> and support <Sup4>
      And <Prop5> having status <Stat5> and resistance <Res5> and support <Sup5>
      And <Prop6> having status <Stat6> and resistance <Res6> and support <Sup6>
    When the results are displayed on agenda
    Then admitted proposals come first
      And they are sorted by resistance ascending
      And they are followed by disregarded proposals sorted by supports descending like already during voting
      And then followed by hidden proposals only visible for supporters
      And <Prop1> appears in display position <DisPos1>
      And <Prop2> appears in display position <DisPos2>
      And <Prop3> appears in display position <DisPos3>
      And <Prop4> appears in display position <DisPos4>
      And <Prop5> appears in display position <DisPos5>
      And <Prop6> appears in display position <DisPos6>
      And a badge showing first rank is shown for proposal <Badge>
      And the result is <Result>

    Examples:
      |	Prop1	|	Prop2	|	Prop3	|	Prop4	|	Prop5	|	Prop6	 |	Stat1	|	Stat2	|	Stat3	|	Stat4	|	Stat5	|	Stat6	|	Res1	|	Res2	|	Res3	|	Res4	|	Res5	|	Res6	|	Sup1	|	Sup2	|	Sup3	|	Sup4	|	Sup5	|	Sup6	|	DisPos1	|	DisPos2	|	DisPos3	|	DisPos4	|	DisPos5	|	DisPos6	|	Badge	|	Result	|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	admitted	“|”	admitted	“|”	admitted	“|”	admitted	“|”	admitted	“|”	admitted	“|”	10	“|”	20	“|”	30	“|”	40	“|”	50	“|”	60	“|”	25	“|”	25	“|”	25	“|”	25	“|”	25	“|”	25	“|”	1	“|”	2	“|”	3	“|”	4	“|”	5	“|”	6	“|”	V1	“|”	okay	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	disregarded	“|”	admitted	“|”	disregarded	“|”	admitted	“|”	hidden	“|”	hidden	“|”	na	“|”	200	“|”	na	“|”	60	“|”	na	“|”	na	“|”	25	“|”	45	“|”	26	“|”	45	“|”	3	“|”	5	“|”	3	“|”	2	“|”	4	“|”	1	“|”	5	“|”	6	“|”	V4	“|”	okay	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	admitted	“|”	admitted	“|”	hidden	“|”	admitted	“|”	disregarded	“|”	hidden	“|”	65	“|”	64	“|”	na	“|”	61	“|”	na	“|”	na	“|”	56	“|”	56	“|”	6	“|”	56	“|”	26	“|”	5	“|”	3	“|”	2	“|”	5	“|”	1	“|”	4	“|”	6	“|”	V4	“|”	okay	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	disregarded	“|”	admitted	“|”	disregarded	“|”	admitted	“|”	admitted	“|”	admitted	“|”	na	“|”	78	“|”	na	“|”	63	“|”	63	“|”	78	“|”	44	“|”	55	“|”	33	“|”	56	“|”	57	“|”	67	“|”	5	“|”	3	“|”	6	“|”	1	“|”	2	“|”	4	“|”	V4, V5	“|”	okay	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	admitted	“|”	admitted	“|”	admitted	“|”	admitted	“|”	admitted	“|”	hidden	“|”	62	“|”	64	“|”	63	“|”	76	“|”	70	“|”	na	“|”	56	“|”	56	“|”	56	“|”	56	“|”	56	“|”	6	“|”	1	“|”	2	“|”	3	“|”	5	“|”	4	“|”	6	“|”	V1	“|”	error: not sorted correctly by resistance	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	disregarded	“|”	admitted	“|”	disregarded	“|”	admitted	“|”	disregarded	“|”	admitted	“|”	na	“|”	76	“|”	na	“|”	75	“|”	na	“|”	74	“|”	43	“|”	67	“|”	32	“|”	67	“|”	21	“|”	56	“|”	1	“|”	6	“|”	2	“|”	5	“|”	3	“|”	4	“|”	V4	“|”	error: not sorted correctly, disregarded before admitted	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	100	“|”	na	“|”	na	“|”	65	“|”	na	“|”	na	“|”	67	“|”	6	“|”	43	“|”	67	“|”	5	“|”	42	“|”	3	“|”	2	“|”	4	“|”	1	“|”	5	“|”	6	“|”	V4	“|”	error: not sorted correctly, mixed	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	101	“|”	na	“|”	na	“|”	66	“|”	na	“|”	na	“|”	67	“|”	4	“|”	45	“|”	67	“|”	3	“|”	46	“|”	2	“|”	5	“|”	3	“|”	1	“|”	6	“|”	4	“|”	V4	“|”	error: sort within disregarded wrong	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	101	“|”	na	“|”	na	“|”	66	“|”	na	“|”	na	“|”	67	“|”	2	“|”	47	“|”	67	“|”	3	“|”	46	“|”	2	“|”	5	“|”	3	“|”	1	“|”	6	“|”	4	“|”	V4	“|”	error: sort within hidden wrong	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	101	“|”	345	“|”	na	“|”	66	“|”	na	“|”	na	“|”	67	“|”	2	“|”	45	“|”	67	“|”	3	“|”	46	“|”	2	“|”	5	“|”	3	“|”	1	“|”	6	“|”	4	“|”	V4	“|”	error: no resistance for hidden proposals	“|
      |”	V1	“|”	V2	“|”	V3	“|”	V4	“|”	V5	“|”	V6	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	admitted	“|”	hidden	“|”	disregarded	“|”	101	“|”	na	“|”	323	“|”	66	“|”	na	“|”	na	“|”	67	“|”	2	“|”	45	“|”	67	“|”	3	“|”	46	“|”	2	“|”	5	“|”	3	“|”	1	“|”	6	“|”	4	“|”	V4	“|”	error: no resistance for disregarded proposals	“|



# ballot details
# votes submitted
# sort order like agenda
# for each proposal: support info; whether it got on the agenda because of high support or by decision of the Caller
#                    type of decision: Konsent if true
#                    resistance sum in relation to maximum resistance

  Scenario: results on ballot details

    Given a ballot with several proposals
    When I open the ballot details
    Then I see the number of votes submitted
      And I see the proposals sorted like on agenda
      And for each proposal I see support information
      And for each admitted proposal I see the resistance it met
      And the proposal with the least resistance is highlighted
      And proposals that did not meet high resistance by anybody get the badge Konsent 


# Elections

# sum up ranks Reihungszahlen for each candidate and for Es werden lieber Plätze unbesetzt gelassen ...
# lowest sum gets  result rank 1

# all candidates with result ranks lower than the threshold result rank are displayed with their result ranks, ascending
# candidates with higher result ranks than the threshold are displayed without their result ranks, also ascending
# number of proposals = number of candidates + 1 for threshold
# threshold text: Es werden lieber Plätze unbesetzt gelassen, als Kandidaten im Gremium zu haben, die unterhalb gereiht wurden.
# disregarded candidates are displayed below the admitted ones with info on supporters only

  Scenario: election results on agenda

    Given an election with several proposals sorted by sum of their ranks Reihungszahlen ascending
      And they are displayed on agenda_results
    When the sum is lower than the sum for threshold
    Then the result rank of the candidate is displayed too.

  Scenario: election results on election details

    Given an election with several proposals
    When I open the election details
    Then I see the number of votes submitted
      And I see the proposals sorted like on agenda
      And for each candidate I see support information
      And for each admitted proposal I see the sum of its ranks
      And the proposals above threshold are highlighted


