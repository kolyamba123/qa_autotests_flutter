// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runner.dart';

// **************************************************************************
// GherkinSuiteTestGenerator
// **************************************************************************

class _CustomGherkinIntegrationTestRunner extends GherkinIntegrationTestRunner {
  _CustomGherkinIntegrationTestRunner(
    TestConfiguration configuration,
    Future<void> Function(World) appMainFunction,
  ) : super(configuration, appMainFunction);

  @override
  void onRun() {
    testFeature0();
  }

  void testFeature0() {
    runFeature(
      'Login page tests:',
      <String>['@all'],
      () {
        runScenario(
          'Login success test Examples: (1)',
          <String>['@all', '@test1'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type login "wiotest@gmail.com"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type password "wiotestpass"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Login button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user "wiotest@gmail.com" on "Home Screen" page',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: () async => onBeforeRunFeature(
            'Login page tests',
            <String>['@all'],
          ),
          onAfter: null,
        );

        runScenario(
          'Login with wrong email test Examples: (1)',
          <String>['@all', '@test2'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type login "wrong@email.com"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type password "wiotestpass"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Login button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user sees message "The user with email wrong@email.com was not found."',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: null,
          onAfter: null,
        );

        runScenario(
          'Login with empty email test',
          <String>['@all', '@test3'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type password "wiotestpass"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Login button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user sees message "Email is empty"',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: null,
          onAfter: null,
        );

        runScenario(
          'Login with invalid email test',
          <String>['@all', '@test4'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type login "wiotestgmail.com"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type password "wiotestpass"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Login button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user sees message "Email is incorrect"',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: null,
          onAfter: null,
        );

        runScenario(
          'Login with empty password test',
          <String>['@all', '@test5'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type login "wiotest@gmail.com"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Login button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user sees message "Password is empty"',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: null,
          onAfter: null,
        );

        runScenario(
          'Login with short password test',
          <String>['@all', '@test6'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type login "wiotest@gmail.com"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type password "lessTh8"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Login button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user sees message "Password is too short"',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: null,
          onAfter: null,
        );

        runScenario(
          'Login with wrong password test Examples: (1)',
          <String>['@all', '@test7'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type login "wiotest@gmail.com"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'When user type password "wrongPass"',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Login button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user sees message "Invalid password for user wiotest@gmail.com"',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: null,
          onAfter: null,
        );

        runScenario(
          'Logout success test',
          <String>['@all', '@test8'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user success login',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Logout button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: null,
          onAfter: null,
        );

        runScenario(
          'Login after logout',
          <String>['@all', '@test9'],
          (TestDependencies dependencies) async {
            await runStep(
              'Given user success login',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Logout button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'And user click on Login button',
              <String>[],
              null,
              dependencies,
            );

            await runStep(
              'Then user on the login page',
              <String>[],
              null,
              dependencies,
            );
          },
          onBefore: null,
          onAfter: () async => onAfterRunFeature(
            'Login page tests',
          ),
        );
      },
    );
  }
}

void executeTestSuite(
  TestConfiguration configuration,
  Future<void> Function(World) appMainFunction,
) {
  _CustomGherkinIntegrationTestRunner(configuration, appMainFunction).run();
}
