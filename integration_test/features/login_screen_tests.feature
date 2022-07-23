@all
Feature: Login page tests

  @test1
  Scenario Outline: Login success test
    Given user on the login page
    When user type login "<email>"
    When user type password "<password>"
    And user click on Login button
    Then user "<email>" on "Home Screen" page
    Examples:
      | email             | password    |
      | wiotest@gmail.com | wiotestpass |

  @test2
  Scenario Outline: Login with wrong email test
    Given user on the login page
    When user type login "<email>"
    When user type password "<password>"
    And user click on Login button
    Then user on the login page
    Then user sees message "The user with email <email> was not found."
    Examples:
      | email           | password    |
      | wrong@email.com | wiotestpass |

  @test3
  Scenario: Login with empty email test
    Given user on the login page
    When user type password "wiotestpass"
    And user click on Login button
    Then user on the login page
    Then user sees message "Email is empty"

  @test4
  Scenario: Login with invalid email test
    Given user on the login page
    When user type login "wiotestgmail.com"
    When user type password "wiotestpass"
    And user click on Login button
    Then user on the login page
    Then user sees message "Email is incorrect"

  @test5
  Scenario: Login with empty password test
    Given user on the login page
    When user type login "wiotest@gmail.com"
    And user click on Login button
    Then user on the login page
    Then user sees message "Password is empty"

  @test6
  Scenario: Login with short password test
    Given user on the login page
    When user type login "wiotest@gmail.com"
    When user type password "lessTh8"
    And user click on Login button
    Then user on the login page
    Then user sees message "Password is too short"

  @test7
  Scenario Outline: Login with wrong password test
    Given user on the login page
    When user type login "<email>"
    When user type password "<password>"
    And user click on Login button
    Then user on the login page
    Then user sees message "Invalid password for user <email>"
    Examples:
      | email             | password  |
      | wiotest@gmail.com | wrongPass |

  @test8
  Scenario: Logout success test
    Given user success login
    And user click on Logout button
    Then user on the login page

  @test9
  Scenario: Login after logout
    Given user success login
    And user click on Logout button
    Then user on the login page
    And user click on Login button
    Then user on the login page