@api



Feature: collecting support
  Background: every associate may support proposals and inquiries to bring them on the agenda

  Scenario Outline: handling support
 
    Given I am an associate Genossenschafter
      And I am logged in
      And the assembly is before DeliberationEnd
    When I handle an <Item>
      And I click the <Button1>
    Then I see <Badge>
      And I am offerd <Button2>
      And the result is <Result>

    Examples:
      |	  Item	|	Button1	|	Badge	|	Button2  	|	Result	|
      |”	Vorschlag	“|”	Unterstützen	“|”	unterstützt	“|”	Unterstützung entziehen	“|”	support added for this item	“|
      |”	Anfrage	“|”	Unterstützen	“|”	unterstützt	“|”	Unterstützung entziehen	“|”	support added for this item	“|
      |”	Vorschlag	“|”	Unterstützung entziehen	“|”		“|”	Unterstützen	“|”	support subtracted for this item	“|
      |”	Anfrage	“|”	Unterstützung entziehen	“|”		“|”	Unterstützen	“|”	support subtracted for this item	“|
      |”	Vorschlag	“|”	Unterstützung entziehen	“|”		“|”		“|”	error, button Unterstützen not offered, support unchanged	“|
      |”	Anfrage	“|”	Unterstützung entziehen	“|”	unterstützt	“|”		“|”	error, badge wrong, support unchanged	“|
      |”	Bericht	“|”	Unterstützen	“|”		“|”		“|”	error, item not supportable	“|
      |”	Status Quo	“|”	Unterstützen	“|”		“|”		“|”	error, item not supportable	“|
      |”	Vorteil	“|”	Unterstützung entziehen	“|”		“|”		“|”	error, item not supportable	“|
      |”	Nachteil	“|”		“|”	unterstützt	“|”		“|”	error, item not supportable	“|
      |”	Vorschlag	“|”	Unterstützen	“|”	unterstützt	“|”	Unterstützen	“|”	error, Button2 wrong, support unchanged	“|
      |”	Anfrage	“|”	Unterstützung entziehen	“|”		“|”	Unterstützung entziehen	“|”	error, Button2 wrong, support unchanged	“|
      |”	Vorschlag	“|”	Unterstützen	“|”		“|”	Unterstützung entziehen	“|”	error, bagde missing, support unchanged	“|





