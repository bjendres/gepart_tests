@api

Feature: Navigation from agenda, depending on phase of asssembly

  Scenario Outline: Links on agenda before deliberation
    Given I am on page agenda Tagesordnung
      And the assembly is future 
      And I have the role <Role>
      And I am not muted
      When I click on <Link>
    Then I am directed to <Page>
      And after submit or cancel I return to <Return>
      And the result is <Result>

  Examples:
    |	Role	|	Link	|	Page	|	Return	|	Result	|
    |	“Genossenschafter”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Vorstand”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Moderator”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Aufsichtsrat”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Genossenschafter”	|	“Abstimmung beantragen”	|	“newballot”	|	“agenda, position like start”	|		|
    |	“Vorstand”	|	“Abstimmung beantragen”	|	“newballot”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Abstimmung beantragen”	|	“newballot”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Abstimmung beantragen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Wahl beantragen”	|	“newelection”	|	“agenda, position like start”	|		|
    |	“Vorstand”	|	“Wahl beantragen”	|	“newelection”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Wahl beantragen”	|	“newelection”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Wahl beantragen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Anfrage stellen”	|	“newinquiry”	|	“agenda, position like start”	|		|
    |	“Vorstand”	|	“Anfrage stellen”	|	“newinquiry”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Anfrage stellen”	|	“newinquiry”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Anfrage stellen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Bericht einbringen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Vorstand”	|	“Bericht einbringen”	|	“newreport”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Vorschlag Abstimmungs-Antrag”	|		|	“agenda, position like start”	|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Vorschlag Wahl-Antrag”	|	“newreport”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“Abstimmungs-Antrag”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Vorstand”	|	“Wahl-Antrag”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Moderator”	|	“Vorstand nominieren”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Vorstand nominieren”	|	“newelection”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“Einberufen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Vorstand”	|	“Einberufen”	|	“call”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Einberufen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Einberufen”	|	“call”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“Unterstützen”	|		|		|	“added to DB, after security checks”	|
    |	“Vorstand”	|	“Unterstützen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Unterstützen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Moderator”	|	“Unterstützen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Melden”	|	“confirmation dialogue”	|	“agenda, position like start”	|	“added to DB, after security checks”	|
    |	“Vorstand”	|	“Beantworten”	|	“newanswer”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Beantworten”	|	“newanswer”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“Beantworten”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Moderator”	|	“Beantworten”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Alternative vorschlagen”	|	“newproposal_xxx”	|	“agenda, position like start”	|		|
    |	“Vorstand”	|	“Alternative vorschlagen”	|	“newproposal_xxx”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Alternative vorschlagen”	|	“newproposal_xxx”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Alternative vorschlagen”	|		|		|	“not allowed, Button not present in GUI”	|



  Scenario Outline: Links on agenda during deliberation
    Given I am on page agenda Tagesordnung
      And the assembly is called and before DeliberationEnd
      And I have the role <Role>
      And I am not muted
    When I click on <Link>
    Then I am directed to <Page>
      And after submit or cancel I return to <Return>
      And the result is <Result>

  Examples:
    |	Role	|	Link	|	Page	|	Return	|	Result	|
    |	“Caller”	|	“Einberufung ändern”	|	“call”	|	“agenda, position like start”	|		|
    |	“other Role”	|	“Einberufung ändern”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Vorstand”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Moderator”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Aufsichtsrat”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Genossenschafter”	|	“Abstimmung beantragen”	|	“newballot”	|	“agenda, position like start”	|		|
    |	“Vorstand”	|	“Abstimmung beantragen”	|	“newballot”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Abstimmung beantragen”	|	“newballot”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Abstimmung beantragen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Wahl beantragen”	|	“newelection”	|	“agenda, position like start”	|		|
    |	“Vorstand”	|	“Wahl beantragen”	|	“newelection”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Wahl beantragen”	|	“newelection”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Wahl beantragen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Anfrage stellen”	|	“newinquiry”	|	“agenda, position like start”	|		|
    |	“Vorstand”	|	“Anfrage stellen”	|	“newinquiry”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Anfrage stellen”	|	“newinquiry”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Anfrage stellen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Bericht einbringen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Vorstand”	|	“Bericht einbringen”	|	“newreport”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Vorschlag Abstimmungs-Antrag”	|		|	“agenda, position like start”	|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Vorschlag Wahl-Antrag”	|	“newreport”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“Abstimmungs-Antrag”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Vorstand”	|	“Wahl-Antrag”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Moderator”	|	“Vorstand nominieren”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Vorstand nominieren”	|	“newelection”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“Einberufen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Vorstand”	|	“Einberufen”	|	“call”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Einberufen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Einberufen”	|	“call”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“Unterstützen”	|		|		|	“added to DB, after security checks”	|
    |	“Vorstand”	|	“Unterstützen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Unterstützen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Moderator”	|	“Unterstützen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Melden”	|	“confirmation dialogue”	|	“agenda, position like start”	|	“added to DB, after security checks”	|
    |	“Vorstand”	|	“Beantworten”	|	“newanswer”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Beantworten”	|	“newanswer”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“Beantworten”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Moderator”	|	“Beantworten”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Alternative vorschlagen”	|	“newproposal_xxx”	|	“agenda, position like start”	|		|
    |	“Vorstand”	|	“Alternative vorschlagen”	|	“newproposal_xxx”	|	“agenda, position like start”	|		|
    |	“Aufsichtsrat”	|	“Alternative vorschlagen”	|	“newproposal_xxx”	|	“agenda, position like start”	|		|
    |	“Moderator”	|	“Alternative vorschlagen”	|		|		|	“not allowed, Button not present in GUI”	|


  Scenario Outline: Links on agenda between deliberation and voting
    Given I am on page agenda Tagesordnung
      And the assembly is between DeliberationEnd and VotingStart
      And I have the role <Role>
      And I am not muted
    When I click on <Link>
    Then I am directed to <Page>
      And after submit or cancel I return to <Return>
      And the result is <Result>

  Examples:
    |	Role	|	Link	|	Page	|	Return	|	Result	|
    |	“Caller”	|	“Einberufung ändern”	|	“call”	|	“agenda, position like start”	|		|
    |	“Caller”	|	“Stimmentzug”	|	“disfranchise”	|	“return by browser button”	|		|
    |	“Caller”	|	“Zulassung entziehen”	|		|		|	“added to DB, after security checks;indicator changes on agenda”	|
    |	“Caller”	|	“Zulassen”	|		|		|	“added to DB, after security checks;indicator changes on agenda”	|
    |	“Caller”	|	“Beantworten”	|	“newanswer”	|	“agenda, position like start”	|		|
    |	“Caller”	|	“Bericht einbringen”	|	“newreport”	|	“agenda, position like start”	|		|
    |	“Genossenschafter”	|	“künftige Generalversammlung”	|	“agenda of next assembly”	|		|		|
    |	“Genossenschafter”	|	“Vorschlag Abstimmungs-Antrag”	|	“ballot”	|		|		|
    |	“Genossenschafter”	|	“Vorschlag Wahl-Antrag”	|	“election”	|		|		|
    |	“Genossenschafter”	|	“Abstimmungs-Antrag”	|	“ballot”	|		|		|
    |	“Genossenschafter”	|	“Wahl-Antrag”	|	“election”	|		|		|
    |	“Genossenschafter”	|	“Einberufung ändern”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Stimmentzug”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Zulassung entziehen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Zulassen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Beantworten”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Bericht einbringen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Genossenschafter”	|	“Melden”	|	“confirmation dialogue”	|	“agenda, position like start”	|	“added to DB, after security checks”	|


  Scenario Outline: Links on agenda and the paths that follow during voting
    Given I am on page agenda Tagesordnung
      And the assembly is between VotingStart and VotingEnd
      And I have the role <Role>
      And I am not muted
    When I click on <Link>
    Then I am directed to <Page>
      And after submit or cancel I return to <Return>
      And the result is <Result>

  Examples:
    |	Role	|	Link	|	Page	|	Return	|	Result	|
    |	“Genossenschafter”	|	“Nicht zugelassene Tagesordnungspunkte”	|		|		|		|
    |	“Genossenschafter”	|	“Wählen”	|	“election_voting”	|	“agenda, position like start”	|	“indicator for voted”	|
    |	“Genossenschafter”	|	“Abstimmen”	|	ballot_voting”	|	“agenda, position like start”	|	“indicator for voted”	|
    |	“Genossenschafter”	|	“künftige Generalversammlung”	|	“agenda of next assembly”	|		|		|
    |	“Genossenschafter”	|	“Generalversammlungen”	|	“history”	|		|		|
    |	“Vorstand”	|	“Wählen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Wählen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Moderator”	|	“Wählen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Vorstand”	|	“Abstimmen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Aufsichtsrat”	|	“Abstimmen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Moderator”	|	“Abstimmen”	|		|		|	“not allowed, Button not present in GUI”	|
    |	“Caller”	|	“Einberufung ändern”	|	“call”	|	“agenda, position like start”	|		|


  Scenario Outline: Links on agenda after voting
    Given I am on page agenda Tagesordnung
      And the assembly is between VotingEnd and ProceedingsEnd
      And I have the role <Role>
      And I am not muted
    When I click on <Link>
    Then I am directed to <Page>
      And I have to return with the return button of the browser
      And the result is <Result>

  Examples:
    |	Role	|	Link	|	Page	|	Result	|
    |	“Genossenschafter”	|	“Stimmzettel”	|	“votes_assembly spreadsheet”	|	“separate download of spreadsheet”	|
    |	“Genossenschafter”	|	“Nicht zugelassene Tagesordnungspunkte”	|	“disregarded”	|		|
    |	“Genossenschafter”	|	“künftige Generalversammlung”	|	“agenda of next assembly”	|		|
    |	“Genossenschafter”	|	“Vorschlag Abstimmungs-Antrag”	|	“ballot_results”	|		|
    |	“Genossenschafter”	|	“Vorschlag Wahl-Antrag”	|	“election_results”	|		|
    |	“Caller”	|	“Protokoll abschließen”	|	“newproceedings”	|	“assembly becomes past”	|
    |	“Genossenschafter”	|	“Protokoll abschließen”	|		|	“not allowed, Button not present in GUI”	|



  Scenario Outline: Links on agenda for past assembly
    Given I am on page agenda Tagesordnung
      And the assembly is past
      And I have the role <Role>
    When I click on <Link>
    Then I am directed to <Page>
      And I have to return with the return button of the browser
      And the result is <Result>

  Examples:
    |	Role	|	Link	|	Page	|	Result	|
    |	“Genossenschafter”	|	“Stimmzettel”	|	“votes_assembly spreadsheet”	|	“separate download of spreadsheet”	|
    |	“Vorstand”	|	“Nicht zugelassene Tagesordnungspunkte”	|	“disregarded”	|		|
    |	“Aufsichtsrat”	|	“Protokoll”	|		|		|
    |	“Moderator”	|	“Vorschlag Abstimmungs-Antrag”	|	“ballot_results, clicked Vorschlag”	|		|
    |	“Genossenschafter”	|	“Vorschlag Wahl-Antrag”	|	“election_results, clicked Vorschlag”	|		|
    |	“Vorstand”	|	“Abstimmungs-Antrag”	|	“ballot_results”	|		|
    |	“Aufsichtsrat”	|	“Wahl-Antrag”	|	“election_results”	|		|


