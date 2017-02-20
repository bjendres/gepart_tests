@api

Feature: support for urgent items

  Scenario Outline: evaluation of support for urgent items

    Given the assembly has not been called yet
      And an <Item1> is marked as urgent by the creator
    When I <Support>  <Item2> connected to <Item1>
      And the sum of supports plus my <Support> of this <Item2> equals <Comparator> 3*(square root (number of voters), rounded down to int)
    Then <Action> is initiated

    Examples:
      |	Item1	|	Item2	|	Support	|	Comparator	|	Action	|
      |”	Anfrage	“|”	Anfrage	“|”	1	“|”	<	“|”	none	“|
      |”	Abstimmungs-Antrag	“|”	Vorschlag zu Abstimmungsantrag	“|”	-1	“|”	<	“|”	none	“|
      |”	Wahl-Antrag	“|”	Vorschlag zu Wahl-Antrag	“|”	1	“|”	<	“|”	none	“|
      |”	Anfrage	“|”	Anfrage	“|”	1	“|”	=	“|”	Mail to all executives and supervisors + badge on agenda	“|
      |”	Abstimmungs-Antrag	“|”	Vorschlag zu Abstimmungsantrag	“|”	1	“|”	=	“|”	Mail to all executives and supervisors + badge on agenda	“|
      |”	Wahl-Antrag	“|”	Vorschlag zu Wahl-Antrag	“|”	1	“|”	=	“|”	Mail to all executives and supervisors + badge on agenda	“|
      |”	Abstimmungs-Antrag	“|”	Abstimmungs-Antrag	“|”	1	“|”		“|”	error: only proposals can be supported	“|
      |”	Wahl-Antrag	“|”	Wahl-Antrag	“|”	1	“|”		“|”	error: only proposals can be supported	“|
      |”	Anfrage	“|”	Anfrage	“|”	-1	“|”	=	“|”	none; mail already sent	“|
      |”	Abstimmungs-Antrag	“|”	Vorschlag zu Abstimmungsantrag	“|”	-1	“|”	=	“|”	none; mail already sent	“|
      |”	Wahl-Antrag	“|”	Vorschlag zu Wahl-Antrag	“|”	-1	“|”	=	“|”	none; mail already sent	“|
      |”	Anfrage	“|”	Anfrage	“|”	1	“|”	>	“|”	none; mail already sent	“|
      |”	Abstimmungs-Antrag	“|”	Vorschlag zu Abstimmungsantrag	“|”	1	“|”	>	“|”	none; mail already sent	“|
      |”	Wahl-Antrag	“|”	Vorschlag zu Wahl-Antrag	“|”	1	“|”	>	“|”	none; mail already sent	“|




 
# threshold for support: 3*(square root (number of voters), rounded down to int)
# before calling


# Wenn ein Antrag/eine Anfrage genügend unterstützt ist ergeht ein Mailhinweis an alle Personen mit Rolle Vorstand oder Aufsichtsrat, und das Datum des Mailversands wird im Tool angezeigt (aber die Unterstützerzahl bleibt bis zur Stimmabgabephase verdeckt).




