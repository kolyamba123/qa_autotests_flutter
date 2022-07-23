// ignore_for_file: avoid_print

import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';
import 'package:qa_automation_integration_test_task/main.dart' as app;

import 'constants/test_constants.dart';
import 'hooks/attach_screenshot_hook.dart';
import 'hooks/attach_logs_hook.dart';
import 'steps/step_definitions_library.dart';
import 'utils/gherkin_reporter.dart';
import 'utils/scenario_context.dart';

part 'runner.g.dart';

@GherkinTestSuite(featureDefaultLanguage: 'en')
void main() async {
  const cliTag = String.fromEnvironment(TestConstants.cliTestTag);
  final testTag = cliTag.isEmpty ? TestConstants.defaultTestTag : cliTag.trim();
  print('-------------- Running tests by tag $testTag --------------');

  executeTestSuite(
    FlutterTestConfiguration.DEFAULT([])
      ..reporters = [
        StdoutReporter(),
        ProgressReporter()
          ..setWriteLineFn(print)
          ..setWriteFn(print),
        TestRunSummaryReporter()
          ..setWriteLineFn(print)
          ..setWriteFn(print),
        GherkinReporter()
      ]
      ..hooks = [
        AttachScreenshotHook(),
        AttachLogsHook(),
      ]
      ..defaultTimeout = const Duration(
        seconds: TestConstants.defaultStepTimeoutSeconds,
      )
      ..order = ExecutionOrder.alphabetical
      ..stepDefinitions = steps
      ..createWorld = ((config) async => ScenarioContext())
      ..tagExpression = testTag,
    (world) => Future<void>(() => app.main()),
  );
}
