@api

Feature: from finalize to voting

#  the assembly is exactly at VotingStart
#  inquiries, ballots and elections without admitted proposals or only the status quo supported are disregarded, go to a separate page, vanish from agenda
#  agenda: disregarded proposals are displayed below admitted ones, no buttons
#  agenda: admitted proposals of ballots and elections with buttons for voting

  Scenario: moving items

    Given the assembly is before VotingStart
    When Voting starts
    Then agenda is reorganized
      And inquiries, ballots and elections without admitted proposals or only the status quo supported are displayed on a separate page and vanish from agenda
      And reports, inquiries, ballots and elections stay sorted by id descending
      And within the ballots and elections the proposals are sorted by id descending
      And the proposals that can be voted for have buttons for voting
      And the disregarded proposals are displayed below them and have no buttons 
