@api

Feature: finalize agenda

  Background: the assembly is after DeliberationEnd and before VotingStart

# supports compared to threshold
# proposals above threshold cannot be disregarded
# proposals below threshold may be admitted by Caller
# inquiries above threshold must be answered on final agenda
# inquiries below threshold may be answered or disregarded, by choice of Caller
# hidden proposals cannot be selected for the final agenda

# on agenda: info block about phases shows Deliberation as past, and no phase as ongoing


  Scenario Outline: starting point of finalizing

# Number of possible supporters = associates
# threshold = 3*square root (number of associates)
# number of supporters > threshold >> badge "NN > MM"   admitted
# number of supporters = threshold >> badge "NN > MM"   admitted
# number of supporters < threshold >> badge "NN"        admit or disregard
#  
    Given I have the <Role>
      And I am logged in with a valid SessionId
      And I am on page agenda
      And I look at an item of type <Item>
    When number of supporters of <Item> is <NN>
      And the threshold  is <MM>
    Then badge shows <Badge>
      And <Button1> <Button2> are offered for this <Item>
      And the result is <Result>

    Examples:
      |	Role	|	Item	|	NN	|	MM	|	Badge	|	Button1	 |	Button2	|	Result	|
      |”	Caller	“|”	inquiry	“|”	4356	“|”	255	“|”	4356 > 255	“|”	Beantworten	“|”	Melden	“|”	okay	“|
      |”	Caller	“|”	inquiry	“|”	254	“|”	255	“|”	254	“|”	Beantworten	“|”	Melden	“|”	okay	“|
      |”	Caller	“|”	proposal	“|”	255	“|”	255	“|”	255 ≥ 255	“|”		“|”		“|”	okay	“|
      |”	Caller	“|”	proposal	“|”	254	“|”	255	“|”	254	“|”	Zulassen	“|”		“|”	okay	“|
      |”	Caller	“|”	proposal	“|”	300	“|”	255	“|”	300 > 255	“|”	Zulassen	“|”		“|”	error: proposals with support > threshold are automatically on agenda	“|
      |”	Caller	“|”	proposal	“|”	200	“|”	255	“|”	200 > 255	“|”		“|”		“|”	error: wrong badge, button Zulassen missing	“|
      |”	Caller	“|”	inquiry	“|”	345	“|”	255	“|”	345 > 255	“|”		“|”	Melden	“|”	error: button Beantworten missing	“|
      |”	associate	“|”	inquiry	“|”	346	“|”	255	“|”	346 > 255	“|”		“|”	Melden	“|”	okay	“|
      |”	associate	“|”	proposal	“|”	125	“|”	255	“|”	125	“|”		“|”		“|”	okay	“|
      |”	associate	“|”	proposal	“|”	126	“|”	255	“|”	126	“|”	Zulassen	“|”		“|”	error: associates may not Zulassen	“|
      |”	associate	“|”	inquiry	“|”	10	“|”	255	“|”	10	“|”	Beantworten	“|”		“|”	error: associates may not Beantworten	“|
  


  Scenario Outline: admit and disregard, and disfranchise

    Given I have the <Role>
      And I am logged in with a valid SessionId
      And I am on page agenda
      And I look at an item of type <Item>
    When I click <Button1>
    Then <Action> happens
      And <Badge> is displayed
      And <Button2> is offered
      And the result is <Result>

    Examples:
      |	Role	|	Item	|	Button1	|	Action	|	Badge	|	Button2	|	Result	|
      |”	Caller	“|”	inquiry	“|”	Beantworten	“|”	newanswer opens	“|”		“|”	Beantworten	“|”	okay	“|
      |”	Caller	“|”	election	“|”	Stimmentzug	“|”	disfranchise opens	“|”		“|”	Stimmentzug	“|”	okay	“|
      |”	Caller	“|”	ballot	“|”	Stimmentzug	“|”	disfranchise opens	“|”		“|”	Stimmentzug	“|”	okay	“|
      |”	Caller	“|”	proposal	“|”	Zulassung entziehen	“|”	disregard saved to db	“|”	No of supports	“|”	Zulassen	“|”	okay	“|
      |”	Caller	“|”	proposal	“|”	Zulassen	“|”	admittance saved to db	“|”	zugelassen mit No of supports	“|”	Zulassung entziehen	“|”	okay	“|
      |”	Caller	“|”		“|”	Bericht einbringen	“|”	newreport opens	“|”		“|”	Bericht einbringen	“|”	okay	“|
      |”	executive	“|”		“|”	Bericht einbringen	“|”	newreport opens	“|”		“|”	Bericht einbringen	“|”	okay	“|
      |”	associate	“|”		“|”	Bericht einbringen	“|”		“|”		“|”		“|”	error: not possible for associates	“|
      |”	supervisor	“|”		“|”	Bericht einbringen	“|”	newreport opens	“|”		“|”	Bericht einbringen	“|”	okay	“|
      |”	associate	“|”	inquiry	“|”	Beantworten	“|”		“|”		“|”		“|”	error: not possible for associates	“|
      |”	associate	“|”	election	“|”	Stimmentzug	“|”		“|”		“|”		“|”	error: not possible for associates	“|
      |”	associate	“|”	ballot	“|”	Stimmentzug	“|”		“|”		“|”		“|”	error: not possible for associates	“|
      |”	associate	“|”	proposal	“|”	Zulassung entziehen	“|”		“|”	No of supports	“|”		“|”	error: not possible for associates	“|
     



