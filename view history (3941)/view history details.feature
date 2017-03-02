@api
Feature: view the list of pending, future, and past assemblies.

  Background: I am logged in

  Scenario Outline: View assembly history in correct order
    Given the newest assembly has assemblyphase <assemblyphase1>
      And the (newest assembly -1) has assemblyphase <assemblyphase2>
    When I attempt to view the  assembly history
    Then I see the assembly history in the order of the newest assembly in <position1>
      And the next youngest (=newest assembly -1) assembly in <position2>
      And the rest following by descending assembly id
      And the result is <Result>

    Examples:
      |	assemblyphase1   | assemblyphase2   | position1   | position2   | Result |
      | "past"           | "past"           | "first"     | "second"    | "okay" |
      | "future"         | "pending"        | "second"    | "first"     | "okay" |
      | "pending"        | "past"           | "first"     | "second"    | "okay" |
      | "future"         | "past"           | "first"     | "second"    | "okay"|
      | "pending"        | "future"         |             |             | "Error: wrong order of assemblyIDs |



  Scenario Outline: Buttons in assembly history view according to role
    Given I have the roles <Role1> and <Role2>
      And the newest assembly has assemblyphase <assemblyphase1>
      And the (newest assembly -1) has assemblyphase <assemblyphase2>
      And the CallerRoleName of the pending assembly is <callerRoleName>
    When I attempt to view the assembly history
    Then I see the assembly history 
      and the link proceedings Protokoll for all past assemblies 
      and the buttons <button1> and <button2> and <button3>
      and the result is <Result>
    Examples:
      | Role1       | Role2    |assemblyphase1  |assemblyphase2|callerRoleName|button1            | button2             | Result |
      |"associate"  |          | "future"       |"past"          |              |                   |                     | "success"|
      |"supervisor" |"moderator"| "future"      |"past"          |              |"Einberufen"         |"Moderation"           | "success"|
      |"executive"  |          | "future"       |"past"          |              |"Einberufen"         |                     | "success"|
      |"associate"  |"moderator" | "future"     |"pending"       | "supervisor"   |                   |"Moderation"           | "success"|
      |"supervisor" |"moderator" | "future"     |"pending"       | "supervisor"   |"Einberufung aendern" |"Protokoll abschliessen"| "success"|
      |"executive"  |          | "future"       |"pending"       | "executive"    |"Einberufung aendern" |"Protokoll abschliessen"| "success"|
      |"moderator"  |          | "future"       |"pending"       | "executive"    |                   |"Moderation"           | "success"|
      |"supervisor" |          | "pending"      | "past"         | "supervisor"   |"Einberufung aendern" |"Protokoll abschliessen"| "success"|
      |"executive"  |          | "pending"      | "past"         | "supervisor"   |                   |                     | "success"|
      |"supervisor" |          | "pending"      | "past"         | "executive"    |                   |                     | "success"|
      |"executive"  |          | "pending"      | "past"         | "executive"    |"Einberufung aendern" |"Protokoll abschliessen"| "success"|
      |"executive"  |"moderator" | "pending"    | "past"         | "supervisor"   |                   |"Moderation"           | "success"|
      |"associate"  |"moderator" | "future"     | "past"         |                |"Einberufen"       |"Moderation"           |"Error: not allowed for associates"|
      |"executive"  |"supervisor"| "pending"    | "past"         | "executive"    |                   |                     |"Error: role conflict" |
      |"supervisor" |          | "pending"      | "past"         | "supervisor"   |"Einberufen"         |                     |"Error: not possible for pending assembly"|
      |"executive"  |          | "future"       | "past"         |              |"Einberufung aendern" |                     |"Error: only for pending assemblies possible"|

# is it allowed to change a call for an assembly between physical assembly and the adding of the proceedings? Is this checked somewhere?
# attention: difficult TCs because CallerRoleName sometimes belongs to newest assembly and sometimes to newest-1, whichever is the pending assembly

#
