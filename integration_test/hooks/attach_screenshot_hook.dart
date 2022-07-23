import 'dart:convert';

import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import '../constants/attachment_file_type.dart';


class AttachScreenshotHook extends Hook {
  static World? _currentWorld;
  static String? _currentStep;
  static const _errorMessage = 'There was no way to take a screenshot.';

  @override
  Future<void> onBeforeStep(World world, String step) async {
    _currentWorld = world;
    _currentStep = step;
  }

  @override
  Future<void> onAfterStep(
    World world,
    String step,
    StepResult stepResult,
  ) async {
    if (stepResult.result == StepExecutionResult.fail ||
        stepResult.result == StepExecutionResult.error ||
        stepResult.result == StepExecutionResult.timeout) {
      await takeScreenshot(world: world, step: step);
    }
  }

  ///This method must be called using 'await'
  ///So that the screenshot has time to attach to the correct step.
  static Future<void> takeScreenshot({World? world, String? step}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        try {
          final currentWorld = (world ?? _currentWorld) as FlutterWorld;
          final data = await currentWorld.appDriver.screenshot();
          currentWorld.attach(
            base64Encode(data),
            AttachmentFileType.imagePng,
            step ?? _currentStep,
          );
        } catch (e) {
          _currentWorld?.attach(
            '$_errorMessage\n$e',
            AttachmentFileType.textPlain,
            step ?? _currentStep,
          );
        }
      },
    );
  }
}
