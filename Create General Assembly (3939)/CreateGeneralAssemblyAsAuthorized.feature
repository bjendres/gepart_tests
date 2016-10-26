Feature: Create General Assembly As Authorized User
  a member of the executive board (Vorstand) or of the supervisory board (Aufsichtsrat)
  defines periods and deadlines and the place of the physical general assembly

  Background:
    Given I am logged in
      And I have the role Vorstand or Aufsichtsrat

  Scenario: Initiate General Assembly creation
    Given There is no future General Assembly
     When I attempt to add a new General Assembly
     Then I am required to submit Type, StartOpinion, EndOpinion, SartVoting, EndVoting, PhysAssembly, Details, Minutes

  Scenario Outline: submit valid dates
    Given There is no future General Assembly
      And I attempt to add a new General assembly
     When I submit <StartOpinion> as StartOpinion
      And I submit <EndOpinion> as EndOpinion
      And I submit <StartVoting> as StartVoting
      And I submit <EndVoting> as EndVoting
      And I submit <PhysAssembly> as PhysAssembly
      And I submit <Minutes> as Minutes
     Then the result is <result>

# Achtung: Es gibt auch den Fall der Änderung, bei dem im Prinzip eine "Eingabe" vergangener Daten möglich sein muss.

     Examples:
       | StartOpinion | EndOpinion | StartVoting | EndVoting | PhysAssembly | Minutes  | result  |
       | today        | today+14   | today+15    | today+22  | today+23     | today+37 | success | # These are valid dates.
       | today        | today-1    | today+15    | today+22  | today+23     | today+37 | error   | # EndOpinion can't be before StartOpinion
       | today        | today+14   | today+12    | today+22  | today+23     | today+37 | error   | # SartVoting can't be before EndOpinion
       | today        | today+14   | today+15    | today+13  | today+23     | today+37 | error   | # EndVoting can't be before StartVoting
       | today        | today+14   | today+15    | today+22  | today+21     | today+37 | error   | # PhysAssembly can't be before EndVoting


   Scenario: Submit no Details
     Given There is no future General Assembly
     Given I attempt to add a new General Assembly
      When I submit valid dates but no value as Details
      Then the result is success
