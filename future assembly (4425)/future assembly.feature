@api

Feature: item for future assembly

# Wenn in der Stimmabgabephase (genauer: nach Abschluß der Meinungsbildung) ein Vorschlag eingebracht wird, wird dieser der künftigen GV zugeordnet. Wenn es noch keine künftige GV gibt, wird diese jetzt erstellt.

# nach Meinungsbildung immer Link auf agenda bereitstellen
# ab erstem Item: Anzeige-Link auf history, unter der laufenden
# noch kein Button Einberufen auf agenda zukünftig, wenn assembly-1 noch nicht abgeschlossen
# kein Phasen-Block auf agenda zukünftig


  Scenario: item for future assembly
    Given the assembly is after DeliberationEnd
      And I want to propose an item
    When I click the link future assembly künftige Generalversammlung
    Then I am directed to the agenda of the future assembly
      And I am offered the buttons to add items

  Scenario: history view

    When there are already items for the future assembly
    Then the future assembly is displayed on history under the ongoing assembly
      And it is a link to the agenda

  Scenario: agenda view

    When there are an ongoing and a future assembly
    Then the agenda of the future assembly offers no link to call the assembly
      And displays no assembly phases
