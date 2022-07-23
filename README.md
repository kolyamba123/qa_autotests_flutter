# qa_automation_integration_test_task

**valid email: wiotest@gmail.com**
**valid password: wiotestpass**

**The password must be at least 8 characters long**

**Command to regenerate after changing any feature file:**


```flutter pub run build_runner clean && flutter pub run build_runner build --delete-conflicting-outputs --config integration_test```

**Running tests:**


```flutter driver --driver=integration_test/driver.dart --target=integration_test/runner.dart```

**Run tests by tag:**


```flutter driver --driver=integration_test/driver.dart --target=integration_test/runner.dart --dart-define=testTag={testTag}```