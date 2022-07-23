import 'package:gherkin/gherkin.dart';

import '../constants/attachment_file_type.dart';

class AttachLogsHook extends Hook {
  static World? _currentWorld;

  @override
  Future<void> onAfterScenarioWorldCreated(
    World world,
    String scenario,
    Iterable<Tag> tags,
  ) async =>
      _currentWorld = world;

  static Future<void> writeLogs(String message, String step) async {
    _currentWorld?.attach(message, AttachmentFileType.textPlain, step);
  }
}
