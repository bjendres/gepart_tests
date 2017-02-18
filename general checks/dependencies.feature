@api

Feature: Dependency of items

  Background: all items depend on their parent (assembly, proposal, inquiry) and cannot be moved to another one

 Scenario Outline: mapping of items and display
    When the <Item> was submitted correctly
      And the <DependingOn> has <ID1>
    Then the <Item> is mapped to <MappedTo> with <ID2>
      And the <Item> is displayed with <Displayed> with <ID3>
      And the author is displayed as <AuthorDisplayed>
      And the result is <Result>
   Examples:
      |	Item	|	DependingOn	|	AuthorDisplayed	|	MappedTo	|	Displayed 	|	ID1	|	ID2	|	ID3	|	Result	|
      |”	Antrag	“|”	GV	“|”	name	“|”	GV	“|”	GV	“|”	nn	“|”	nn	“|”	nn	“|”	correct mapping	“|
      |”	Wahl-Antrag	“|”	GV	“|”	name	“|”	GV	“|”	GV	“|”	nn	“|”	nn	“|”	nn	“|”	correct mapping	“|
      |”	Anfrage	“|”	GV	“|”	name	“|”	GV	“|”	GV	“|”	nn	“|”	nn	“|”	nn	“|”	correct mapping	“|
      |”	Bericht	“|”	GV	“|”	role	“|”	GV	“|”	GV	“|”	nn	“|”	nn	“|”	nn	“|”	correct mapping	“|
      |”	Vorteil	“|”	Vorschlag	“|”	name	“|”	Vorschlag	“|”	Vorschlag	“|”	nn	“|”	nn	“|”	nn	“|”	correct mapping	“|
      |”	Nachteil	“|”	Vorschlag	“|”	name	“|”	Vorschlag	“|”	Vorschlag	“|”	nn	“|”	nn	“|”	nn	“|”	correct mapping	“|
      |”	Vorschlag	“|”	Antrag	“|”	name	“|”	Antrag	“|”	Antrag	“|”	nn	“|”	nn	“|”	nn	“|”	correct mapping	“|
      |”	Antwort	“|”	Anfrage	“|”	role	“|”	Anfrage	“|”	Anfrage	“|”	nn	“|”	nn	“|”	nn	“|”	correct mapping	“|
      |”	Antrag	“|”	GV	“|”	role	“|”	GV	“|”	GV	“|”	nn	“|”	nn	“|”	nn	“|”	error author not named	“|
      |”	Wahl-Antrag	“|”	GV	“|”	name	“|”	Vorschlag	“|”	GV	“|”	nn	“|”	nn	“|”	nn	“|”	error mapped to wrong item	“|
      |”	Anfrage	“|”	GV	“|”	name	“|”	GV	“|”	Anfrage	“|”	nn	“|”	nn	“|”	nn	“|”	error displayed with wrong item	“|
      |”	Bericht	“|”	GV	“|”	name	“|”	GV	“|”	GV	“|”	nn	“|”	nn	“|”	nn	“|”	error author named	“|
      |”	Vorteil	“|”	Vorschlag	“|”	name	“|”	Vorschlag	“|”	GV	“|”	nn	“|”	nn	“|”	nn	“|”	error displayed with wrong item type	“|
      |”	Nachteil	“|”	Vorschlag	“|”	name	“|”	GV	“|”	Vorschlag	“|”	nn	“|”	nn	“|”	nn	“|”	error mapped to wrong item type	“|
      |”	Vorschlag	“|”	Vorschlag	“|”	name	“|”	Antrag	“|”	Antrag	“|”	nn	“|”	nn	“|”	nn	“|”	error depending on wrong item type	“|
      |”	Antwort	“|”	Anfrage	“|”	role	“|”	Anfrage	“|”	Anfrage	“|”	nn	“|”	nn +1	“|”	nn	“|”	error mapped to wrong item id	“|
      |”	Abstimmungs-Antrag	“|”	GV	“|”	name	“|”	GV	“|”	GV	“|”	nn	“|”	nn	“|”	nn+1	“|”	error displayed with wrong item id	“|
      |”	Wahl-Antrag	“|”	GV	“|”	name	“|”	GV	“|”	GV	“|”	nn	“|”	nn -1	“|”	nn -1	“|”	error mapped to wrong item id	“|
      |”	Anfrage	“|”	GV	“|”	name	“|”	GV	“|”	GV	“|”	nn	“|”		“|”	nn	“|”	error not saved to db	“|
      |”	Bericht	“|”	GV	“|”	role	“|”	GV	“|”	GV	“|”	nn	“|”	nn	“|”		“|”	error not displayed	“|



