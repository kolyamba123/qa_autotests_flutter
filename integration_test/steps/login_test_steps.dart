import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';
import '../utils/scenario_context.dart';
import '../utils/widget_tester_utils.dart';
import '../screens/login_test_screen.dart';
import '../constants/test_data.dart';

class LoginTestSteps {
  static Iterable<StepDefinitionGeneric<ScenarioContext>> get steps => [
    given<ScenarioContext>(RegExp(r'user on the login page$'),
            (context) async {
          final tester = context.world.rawAppDriver;
          await tester.pumpUntilVisible(LoginTestScreen.loginPageIcon);
        }),
    when1<String, ScenarioContext>(RegExp(r'user type login {String}$'),
            (login, context) async {
          final tester = context.world.rawAppDriver;
          await tester.tap(LoginTestScreen.emailField);
          await tester.enterTextWithPump(
              LoginTestScreen.emailField, login);
        }),
    when1<String, ScenarioContext>(RegExp(r'user type password {String}$'),
            (pwd, context) async {
          final tester = context.world.rawAppDriver;
          await tester.tap(LoginTestScreen.passwordField);
          await tester.enterTextWithPump(
              LoginTestScreen.passwordField, pwd);
        }),
    and<ScenarioContext>(RegExp(r'user click on Login button'),
            (context) async {
          final tester = context.world.rawAppDriver;
          await tester.tapWithPump(LoginTestScreen.loginButton);
          await Future.delayed(Duration(milliseconds: 500));
    }),
    and<ScenarioContext>(RegExp(r'user click on Logout button'),
            (context) async {
          final tester = context.world.rawAppDriver;
          await tester.tapWithPump(LoginTestScreen.logoutButton);
          await Future.delayed(Duration(milliseconds: 500));
        }),
    then2<String, String, ScenarioContext>(RegExp(r'user {String} on {String} page$'),
            (user, pageName, context) async {
          final tester = context.world.rawAppDriver;
          await tester.pumpAndSettle();
          expect(find.text('Hello ' + user), findsOneWidget);
          expect(find.text(pageName), findsOneWidget);
        }),
    then1<String, ScenarioContext>(RegExp(r'user sees message {String}$'),
            (msg, context) async {
          final tester = context.world.rawAppDriver;
          await tester.pumpAndSettle();
          expect(find.text(msg), findsOneWidget);
        }),
    then<ScenarioContext>(RegExp(r'user on the login page$'),
            (context) async {
          final tester = context.world.rawAppDriver;
          await tester.pumpUntilVisible(LoginTestScreen.loginPageIcon);
        }),
    given<ScenarioContext>(RegExp(r'user success login$'),
            (context) async {
          final tester = context.world.rawAppDriver;
          await tester.pumpUntilVisible(LoginTestScreen.loginPageIcon);
          await tester.tap(LoginTestScreen.emailField);
          await tester.enterTextWithPump(
              LoginTestScreen.emailField, TestData.testEmail);
          await tester.tap(LoginTestScreen.passwordField);
          await tester.enterTextWithPump(
              LoginTestScreen.passwordField, TestData.testPassword);
          await tester.tapWithPump(LoginTestScreen.loginButton);
          await tester.pumpAndSettle();
          expect(find.text('Hello ' + TestData.testEmail), findsOneWidget);
          expect(LoginTestScreen.homeScreenValue, findsOneWidget);
          await Future.delayed(Duration(milliseconds: 500));
        })
  ];
}
