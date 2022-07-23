import 'dart:io';

import '../constants/test_constants.dart';

abstract class PermissionUtils {
  static Future<void> setAndroidPermissions() async {
    final permissions = [
      _AndroidPermissions.camera,
      _AndroidPermissions.recordAudio,
      _AndroidPermissions.accessFineLocation,
      _AndroidPermissions.accessCoarseLocation,
    ];

    for (var permission in permissions) {
      await Process.run(_AndroidCommands.adb, [
        ..._AndroidCommands.shellPmGrant,
        TestConstants.appPackageName,
        permission
      ]);
    }
  }

  static Future<void> setIOSPermissions() async {
    await Process.run(_IOSCommands.xcrun, [
      ..._IOSCommands.simctlSpawnBooted,
      _IOSPermissions.notifyUtil,
      _IOSCommands.sFlag,
      TestConstants.productBundleId,
      '1'
    ]);
    await Process.run(_IOSCommands.xcrun, [
      ..._IOSCommands.simctlSpawnBooted,
      _IOSPermissions.notifyUtil,
      _IOSCommands.pFlag,
      TestConstants.productBundleId
    ]);
    await Process.run(_IOSCommands.xcrun, [
      _IOSCommands.simctl,
      _IOSCommands.privacy,
      _IOSCommands.booted,
      _IOSCommands.grant,
      _IOSPermissions.locationAlways,
      TestConstants.productBundleId,
    ]);
  }
}

class _AndroidPermissions {
  static const camera = 'android.permission.CAMERA';
  static const recordAudio = 'android.permission.RECORD_AUDIO';
  static const accessFineLocation = 'android.permission.ACCESS_FINE_LOCATION';
  static const accessCoarseLocation =
      'android.permission.ACCESS_COARSE_LOCATION';
}

class _AndroidCommands {
  static const adb = 'adb';
  static const shell = 'shell';
  static const pm = 'pm';
  static const grant = 'grant';
  static const shellPmGrant = [shell, pm, grant];
}

class _IOSPermissions {
  static const locationAlways = 'location-always';
  static const notifyUtil = 'notifyutil';
}

class _IOSCommands {
  static const xcrun = 'xcrun';
  static const simctl = 'simctl';
  static const spawn = 'spawn';
  static const booted = 'booted';
  static const privacy = 'privacy';
  static const grant = 'grant';
  static const pFlag = '-p';
  static const sFlag = '-s';
  static const simctlSpawnBooted = [simctl, spawn, booted];
}
