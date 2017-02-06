@api

Feature: order of items on agenda

  Background: all ballots, elections, inquiries and reports belong to exactly one assembly
  and are shown sorted by ceation time, newest first

  Scenario: order of items static
    When I go the agenda of an ongoing assembly before DeliberationEnd
    Then I see all the ballots, elections, inquiries and reports belonging to this assembly
      And they are sorted by creation time descending
      And the proposals for ballots are shown under their ballot
      And the proposals for elections are shown under the election they belong to
      And both these proposals are sorted by creation time descending

  Scenario: pagination
    Given there are more then 10 items on the agenda
    When I go to the agenda
    Then I see maximum 10 items on a page
    And I see pagination at the bottom for navigation

  Scenario: added items during reading
    Given there are more then 10 items on the agenda
      And I am on a page > page1
    When someone else creates a new item
    Then all the items are pushed down one place
      And I see the last item of my previous page on top of my page

  Scenario: added items between sessions
    Given I have visited the agenda of the ongoing assembly before
      And somebody has added an item since my last visit
    When I log in again
      And I visit agenda
    Then I see the new item with a new-badge

  Scenario: hidden items
    Given an item I created was hidden by a moderator
    When I visit the agenda
    Then I see that item in its place with a badge
    But nobody else sees this item

  Scenario: order of items during voting
    Given the assembly is between VotingStart and VotingEnd
    When I visit the agenda
    Then I see all the permitted zugelassenen items sorted by unabgestimmt before abgestimmt
      And within these blocks sorted by creation time descending
      And within a ballot the proposals are sorted by creation time descending
      And a proposal Weitermachen wie bisher is added at the top
      And within an election the proposals are sorted by creation time descending
      And a proposal Ich würde lieber Plätze unbesetzt lassen, als Kandidaten im Gremium zu haben, die ich unterhalb gereiht habe is added at the top 

  Scenario: order of items for results
    Given an assembly is after VotingEnd
    When I visit the agenda for this assembly
    Then I see the proposals for each ballot and election sorted be number of votes, descending



