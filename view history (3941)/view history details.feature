
Feature: view the list of pending, future, and past assemblies.

  Background: I am logged in

  Scenario Outline: View assembly history in correct order
    Given the newest assembly has assemblyphase <assemblyphase1>
      And the (newest assembly -1) has assemblyphase <assemblyphase2>
    When I attempt to view the  assembly history
    Then I see the assembly history in the order of the newest assembly in
      <position1> and the next youngest (=newest assembly -1) assembly in <position2>, 
      the rest following by descending assembly id. 
  	
    Examples:
      |	assemblyphase1 | assemblyphase2 | position1 | position2 |
      | past           | past           | first     | second    |
      | future         | pending        | second    | first     |
      | pending        | past           | first     | second    |
      | future         | past           | first     | second    |
      | pending        | future         |           |           |Error: wrong order of assemblyIDs
      | past           | pending        |           |           |Error: wrong order of assemblyIDs
      | past           | future         |           |           |Error: wrong order of assemblyIDs



  Scenario Outline: Buttons in assembly history view according to role
    Given I have the roles <Role1> and <Role2>
      And the newest assembly has assemblyphase <assemblyphase1>
      And the (newest assembly -1) has assemblyphase <assemblyphase2>
      And the CallerRoleName of the pending assembly is <callerRoleName>
    When I attempt to view the assembly history
    Then I see the assembly history 
      and the buttons "Protokoll" for all past assemblies 
      and the buttons <button1> and <button2> and <button3>
      and the result is <Result>
    Examples:
      | Role1     | Role2    |assemblyphase1|assemblyphase2|callerRoleName|button1            | button2             | button3    | Result | 
      |associate  |          | future       |past          |              |                   |                     |            | success|
      |supervisor |moderator | future       |past          |              |Einberufen         |Moderation           |            | success|
      |executive  |          | future       |past          |              |Einberufen         |                     |            | success|
      |associate  |moderator | future       |pending       | supervisor   |                   |Moderation           |            | success|
      |supervisor |moderator | future       |pending       | supervisor   |Einberufung ändern |Protokoll abschließen| Moderation | success|
      |executive  |          | future       |pending       | executive    |Einberufung ändern |Protokoll abschließen|            | success|
      |moderator  |          | future       |pending       | executive    |                   |Moderation           |            | success|   
      |executive  |          | future       |pending       | executive    |Einberufung ändern |Protokoll abschließen| Einberufen | Error: assembly may be called only when assembly-1 is past | 
      |supervisor |          | pending      | past         | supervisor   |Einberufung ändern |Protokoll abschließen|            | success|
      |executive  |          | pending      | past         | supervisor   |                   |                     |            | success|
      |supervisor |          | pending      | past         | executive    |                   |                     |            | success|
      |executive  |moderator | pending      | past         | executive    |Einberufung ändern |Protokoll abschließen| Moderation | success|
      |executive  |moderator | pending      | past         | supervisor   |                   |Moderation           |            | success|
      |associate  |moderator | future       | past         |              |Einberufen         |Moderation           |            | Error: not allowed for associates| 
      |supervisor |          | pending      | past         | supervisor   |Einberufen         |                     |            | Error: not possible for pending assembly|
      |executive  |          | future       | past         |              |Einberufung ändern |                     |            | Error: only for pending assemblies possible|
  
# is it allowed to change a call for an assembly between physical assembly and the adding of the proceedings? Is this checked somewhere?
# attention: difficult TCs because CallerRoleName sometimes belongs to newest assembly and sometimes to newest-1, whichever is the pending assembly

#


