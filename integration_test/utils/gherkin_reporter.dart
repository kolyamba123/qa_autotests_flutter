import 'dart:convert';

import 'package:gherkin/gherkin.dart';
import 'package:gherkin/src/reporters/json/json_feature.dart';
import 'package:gherkin/src/reporters/json/json_scenario.dart';
import 'package:gherkin/src/reporters/json/json_step.dart';
import 'package:gherkin/src/reporters/json/json_tag.dart';

import '../hooks/attach_logs_hook.dart';

class GherkinReporter extends Reporter implements SerializableReporter {
  final _features = <JsonFeature>[];
  final _unnamedDescription =
      'Something is logged before any feature has started to execute';

  @override
  Future<void> onFeatureStarted(StartedMessage message) async {
    _features.add(JsonFeature.from(message));
  }

  @override
  Future<void> onScenarioStarted(StartedMessage message) async {
    if (_features.isEmpty) onFeatureStarted(message);
    _getCurrentFeature().add(JsonScenario.from(message));
  }

  @override
  Future<void> onStepStarted(StepStartedMessage message) async {
    _getCurrentFeature().currentScenario().add(JsonStep.from(message));
  }

  @override
  Future<void> onStepFinished(StepFinishedMessage message) async {
    final step = message.context.lineText;
    final result = message.result;
    if (result is ErroredStepResult) {
      AttachLogsHook.writeLogs(
        '${result.exception}\n\n${result.stackTrace}',
        step,
      );
    }
    _getCurrentFeature().currentScenario().currentStep().onFinish(message);
  }

  @override
  Future<void> onException(Object exception, StackTrace stackTrace) async {
    _getCurrentFeature()
        .currentScenario()
        .currentStep()
        .onException(exception, stackTrace);
  }

  JsonFeature _getCurrentFeature() {
    if (_features.isEmpty) {
      final jsonStep = JsonStep()
        ..name = 'Unnamed'
        ..line = 0;
      final jsonScenario = JsonScenario()
        ..target = Target.scenario
        ..name = 'Unnamed'
        ..description = _unnamedDescription
        ..line = 0
        ..tags = <JsonTag>[]
        ..steps = <JsonStep>[jsonStep];
      final feature = JsonFeature()
        ..name = 'Unnamed feature'
        ..description = _unnamedDescription
        ..line = 0
        ..tags = <JsonTag>[]
        ..uri = 'unknown'
        ..scenarios = <JsonScenario>[jsonScenario];

      _features.add(feature);
    }

    return _features.last;
  }

  @override
  String toJson() {
    return json.encode(_features);
  }
}
