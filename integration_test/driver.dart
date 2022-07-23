// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver.dart' as it_driver;
import 'package:integration_test/common.dart';
import 'package:integration_test/integration_test_driver.dart';

import 'constants/test_constants.dart';
import 'utils/permission_utils.dart';

Future<void> main() async {
  it_driver.testOutputsDirectory = 'integration_test/gherkin/reports';
  await PermissionUtils.setAndroidPermissions();
  return startIntegrationDriver(responseDataCallback: writeGherkinReports);
}

Future<void> startIntegrationDriver({
  Duration timeout =
      const Duration(minutes: TestConstants.defaultTestsTimeoutMinutes),
  ResponseDataCallback? responseDataCallback = writeResponseData,
}) async {
  final driver = await FlutterDriver.connect();
  final jsonResult = await driver.requestData(null, timeout: timeout);
  final response = Response.fromJson(jsonResult);

  await driver.close();
  final resultMessage = response.allTestsPassed
      ? 'All tests passed.'
      : 'Failure Details:\n${response.formattedFailureDetails}';
  log(resultMessage);

  if (responseDataCallback != null) await responseDataCallback(response.data);
  exit(0);
}

Future<void> writeGherkinReports(Map<String, dynamic>? data) async {
  const rawReportName = 'gherkin_reports';
  await it_driver.writeResponseData(data, testOutputFilename: rawReportName);

  final reports = json.decode(data![rawReportName].toString()) as List<dynamic>;
  for (var i = 0; i < reports.length; i++) {
    final reportData = reports.elementAt(i) as List<dynamic>;

    await fs
        .directory('${it_driver.testOutputsDirectory}/output')
        .create(recursive: true);
    final File file = fs.file(
      path.join(it_driver.testOutputsDirectory, 'output/report_$i.json'),
    );
    final String resultString =
        const JsonEncoder.withIndent('  ').convert(reportData);
    await file.writeAsString(resultString);
  }
}
