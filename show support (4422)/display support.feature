@api

Feature: display support

# while support is collected, nobody can see it

  Scenario Outline: display support depending on phase
#    Given an assembly is not past
    When the assembly is after <Date1> and before <Date2>
      And an item is an <Item>
      And the item is <Admitted>
    Then the number of supporters is displayed at <Place>
      And the result is <Result>

    Examples: 
      |	Date1	|	Date2	|	Item	|	Admitted	|	Place	|	Result	|
      |”		“|”	DeliberationEnd	“|”	Wahl-Vorschlag	“|”		“|”	nowhere	“|”	okay	“|
      |”		“|”	DeliberationEnd	“|”	Abstimmungs-Vorschlag	“|”		“|”	nowhere	“|”	okay	“|
      |”		“|”	DeliberationEnd	“|”	Anfrage	“|”		“|”	nowhere	“|”	okay	“|
      |”	DeliberationEnd	“|”	VotingEnd	“|”	Wahl-Vorschlag	“|”	admitted	“|”	on agenda, besides the title of the proposal	“|”	okay	“|
      |”	DeliberationEnd	“|”	VotingEnd	“|”	Abstimmungs-Vorschlag	“|”	admitted	“|”	on agenda, besides the title of the proposal	“|”	okay	“|
      |”	DeliberationEnd	“|”	VotingEnd	“|”	Anfrage	“|”	admitted	“|”	on agenda, besides the title of the inquiry	“|”	okay	“|
      |”	DeliberationEnd	“|”		“|”	Wahl-Antrag	“|”	disregarded	“|”	on list of disregarded items,  besides the title of the election	“|”	okay	“|
      |”	DeliberationEnd	“|”		“|”	Abstimmungs-Antrag	“|”	disregarded	“|”	on list of disregarded items,  besides the title of the ballot	“|”	okay	“|
      |”	DeliberationEnd	“|”		“|”	Anfrage	“|”	disregarded	“|”	on list of disregarded items,  besides the title of the inquiry	“|”	okay	“|
      |”	VotingEnd	“|”		“|”	Wahl-Vorschlag	“|”	admitted	“|”	details of election, besides title of the proposal	“|”	okay	“|
      |”	VotingEnd	“|”		“|”	Abstimmungs-Vorschlag	“|”	admitted	“|”	details of ballot, besides title of proposal	“|”	okay	“|
      |”	VotingEnd	“|”		“|”	Anfrage	“|”	admitted	“|”	nowhere	“|”	okay	“|
      |”		“|”	Calling	“|”	Abstimmungs-Antrag	“|”		“|”	on agenda, besides the title of the proposal	“|”	error: wrong time, support not displayed	“|
      |”	DeliberationEnd	“|”	VotingEnd	“|”	Wahl-Vorschlag	“|”	disregarded	“|”	on agenda, besides the title of the proposal, under admitted proposals	“|”	okay	“|
      |”	DeliberationEnd	“|”	VotingEnd	“|”	Abstimmungs-Vorschlag	“|”	admitted	“|”	on list of disregarded items,  besides the title of the item	“|”	error: wrong place	“|
      |”	Voting End	“|”		“|”	Anfrage	“|”	admitted	“|”	on agenda, besides the title of the inquiry	“|”	error: wrong place, time	“|
      |”	Voting End	“|”		“|”	Wahl-Vorschlag	“|”	disregarded	“|”	details of election, besides title of the proposal, under admitted proposals	“|”	okay	“|
      |”	Voting End	“|”		“|”	Abstimmungs-Vorschlag	“|”	disregarded	“|”	details of ballot, besides title of proposal, under admitted proposals	“|”	okay	“|





# after DeliberationEnd and before VotingStart the supporters for all possible items are counted and all can see their number (except for hidden ausgeblendet items) on the agenda
# from VotingStart to VotingEnd for admitted items: on agenda, besides the title of the item
# after VotingStart for disregarded ballots and elections -Anträge and for disregarded inquiries Anfragen: on list of disregarded items,  besides the title of the item
# after VotingStart for disregarded proposals: with the ballot or election they belong to
# after VotingEnd for admitted items: with the details of the ballot or election; not available for answered inquiries
# after VotingEnd the spread sheet shows the supports per associate per item for all items

# in case of change of periods for deliberation or voting the display of supports needs to be adapted according to rules for phase
# the number of possible supporters is displayed on agenda after DeliberationEnd

  Scenario: supports per item per person
    When the assembly is after VotingEnd
    Then the support for each item by each associate Genossenschafter is shown in a spread sheet.

# see TCs for requirement 4424, cvs
