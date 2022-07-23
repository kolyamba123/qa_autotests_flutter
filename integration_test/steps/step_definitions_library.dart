import 'package:gherkin/gherkin.dart';

import '../utils/scenario_context.dart';
import 'login_test_steps.dart';

Iterable<StepDefinitionGeneric<ScenarioContext>> steps = [
  ...LoginTestSteps.steps,
];
