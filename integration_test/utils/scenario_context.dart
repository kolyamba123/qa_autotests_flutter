import 'package:flutter_gherkin/flutter_gherkin.dart';

class ScenarioContext extends FlutterWidgetTesterWorld {
  final Map<String, dynamic> _scenarioContext = <String, dynamic>{};

  @override
  void dispose() {
    super.dispose();
    _scenarioContext.clear();
  }

  T getContext<T>(String key) {
    return _scenarioContext[key] as T;
  }

  void setContext(String key, dynamic value) {
    _scenarioContext[key] = value;
  }
}
