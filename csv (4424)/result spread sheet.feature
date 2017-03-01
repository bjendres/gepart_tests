@api

Feature: result spread sheet

# alle Genossenschafter, mit GenoNummer, Stummschaltung

# alle Anfragen Unterstützungen
# alle Anträge, auch nicht zugelassene, mit Stimmentzug, status quo
#    alle Vorschläge
#      alle Unterstützungen mit Info über Zulassung trotz wenig Unterstützung = zugelassen, nicht-zugelassen, ausgeblendet
#      alle Stimmen Widerstand/Reihungszahl
#      alle Begründungen

#  Sortierung: Reihen: Genossenschafter alphabetisch
#              Spalten: Anfragen und Anträge nach Id aufsteigend
#
# zugänglich über Stimmzettel

# Content: for one assembly: participating associates, their supports, votes, and arguments for votes, muted or disfranchised, all ballots, elections and inquiries
#
#sort order:
#
# rows: by name of associates, alphabetically, ascending
# columns:
# name of associate  Name
# Id                 GenoNr
# muted              Stummschaltung
#
# followed by
# inquiries, ballots and elections by there item number,  sorted ascending, plus an attribute 
#
# attribute for inquiry is support Unterstützung
# attributes for ballot Abstimmungs-Antrag und election Wahl-Antrag are disfranchised Stimmentzug and resistance/sequence number Widerstand/Reihungszahl for status quo
# after each column of a ballot follow the columns for the proposals for this ballot, with attributes
#      support Unterstützung or Unterstützung(ausgeblendet) or Unterstützung (nicht zugelassen) or Unterstützung (zugelassen),
#      resistance Widerstand
#      argument Begründung
# after each column of a election Wahl-Antrag follow the columns for the proposals for this election, with the attributes
#      support Unterstützung or Unterstützung(ausgeblendet) or Unterstützung (nicht zugelassen) or Unterstützung (zugelassen),
#      sequence number Reihungszahl
#      argument Begründung
#
#  empty columns are deleted


  Scenario: layout
    When I open the result spread sheet Stimmzettel
    Then I see all supports, votes, arguments and special attributes of all associates that participated
      And they are arranged like described in the comments 
