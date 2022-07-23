import 'package:flutter_test/flutter_test.dart';

/// The minimum time that will occur between actions with widgets
/// It is necessary that most animations have time to complete
const Duration _minimalInteractionDelay = Duration(milliseconds: 50);

/// The time that pumpUntil* methods will be executed before completion by default
const Duration _defaultPumpTimeout = Duration(seconds: 10);

/// Time between pump inside pumpUntil* methods to release the thread
const Duration _minimalPumpDelay = Duration(milliseconds: 50);

/// General utilities over Widget Tester for convenience and code reuse
extension WidgetTesterUtils on WidgetTester {

  /// Function for waiting
  Future<void> wait(Duration duration) async {
    await Future.delayed(duration);
  }

  /// Function in order to pump() a certain time when it is impossible to use
  /// pumpAndSettle() or just pump()
  Future<void> pumpForDuration(Duration duration) async {
    final stopwatch = Stopwatch()..start();
    while (stopwatch.elapsed < duration) {
      await pump(_minimalPumpDelay);
    }
  }

  /// Method to pump() until the animation finishes or until the timeout if the animation is long
  /// Allows you to skip transitions across screens without using [pumpForDuration]
  Future<void> pumpUntilSettled({
    Duration timeout = _defaultPumpTimeout,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (stopwatch.elapsed < timeout && binding.hasScheduledFrame) {
      await pump(_minimalPumpDelay);
    }
  }

  /// Method for doing pump() until the condition [condition] occurs
  Future<bool> pumpUntilCondition(
    bool Function() condition, {
    Duration timeout = _defaultPumpTimeout,
  }) async {
    final stopwatch = Stopwatch()..start();
    var instant = true;
    while (stopwatch.elapsed < timeout) {
      if (condition()) {
        // we add an additional delay if we didn't find it right away
        // most likely there is an animation
        if (!instant) await pumpForDuration(_minimalInteractionDelay);
        return true;
      }
      await pump(_minimalPumpDelay);
      instant = false;
    }
    return false;
  }

  /// The function will do pump() until the widget is detected
  Future<bool> pumpUntilVisible(
    Finder target, {
    Duration timeout = _defaultPumpTimeout,
    bool doThrow = true,
  }) async {
    bool condition() => target.evaluate().isNotEmpty;
    final found = await pumpUntilCondition(condition, timeout: timeout);
    if (!found && doThrow) {
      throw TestFailure('Target was not found ${target.toString()}');
    }
    return found;
  }

  /// The function will do pump() until any of the widgets list is detected
  Future<void> pumpUntilVisibleAny(
    List<Finder> targetList, {
    Duration timeout = _defaultPumpTimeout,
  }) async {
    bool condition() =>
        targetList.any((target) => target.evaluate().isNotEmpty);
    final found = await pumpUntilCondition(condition, timeout: timeout);
    if (!found) {
      throw TestFailure('None of targets were found ${targetList.toString()}');
    }
  }

  /// The function will do pump() until the widget disappears
  /// May not work in some situations despite offstage = true
  Future<bool> pumpUntilNotVisible(
    Finder target, {
    Duration timeout = _defaultPumpTimeout,
    bool doThrow = true,
  }) async {
    bool condition() => target.evaluate().isEmpty;
    final found = await pumpUntilCondition(condition, timeout: timeout);
    if (!found && doThrow) {
      throw TestFailure('Target did not disappear ${target.toString()}');
    }
    return found;
  }

  /// The function will do pump() until any of the widgets list disappears
  Future<void> pumpUntilNotVisibleAny(
    List<Finder> targetList, {
    Duration timeout = _defaultPumpTimeout,
  }) async {
    bool condition() => targetList.any((target) => target.evaluate().isEmpty);
    final found = await pumpUntilCondition(condition, timeout: timeout);
    if (!found) {
      throw TestFailure(
          'None of targets did disappear ${targetList.toString()}');
    }
  }

  /// The function will pump() until the number of [target] on the screen becomes less than [amount]
  Future<void> pumpUntilVisibleLessThan(
    Finder target,
    int amount, {
    Duration timeout = _defaultPumpTimeout,
  }) async {
    bool condition() => target.evaluate().length < amount;
    final found = await pumpUntilCondition(condition, timeout: timeout);
    if (!found) {
      throw TestFailure(
          'Amount of targets was not less than $amount ${target.toString()}');
    }
  }

  /// The function will do a pump() until the number of [target] on the screen becomes equal to [amount]
  Future<void> pumpUntilVisibleAmount(
    Finder target,
    int amount, {
    Duration timeout = _defaultPumpTimeout,
  }) async {
    bool condition() => target.evaluate().length == amount;
    final found = await pumpUntilCondition(condition, timeout: timeout);
    if (!found) {
      throw TestFailure('There were not $amount targets ${target.toString()}');
    }
  }

  /// The function will do pump() until the number of visible elements decreases
  /// It is useful when there are two loaders on the screen
  Future<void> pumpUntilLessVisible(
    Finder target, {
    Duration timeout = _defaultPumpTimeout,
  }) async {
    final initialCount = target.evaluate().length;
    bool condition() => target.evaluate().length < initialCount;
    final found = await pumpUntilCondition(condition, timeout: timeout);
    if (!found) {
      throw TestFailure(
          'Amount of targets did not decrease ${target.toString()}');
    }
  }

  /// The function does tap() and immediately pump()
  /// To remove redundant pump calls() from the steps code
  Future<void> tapWithPump(
    Finder finder, {
    Duration timeout = _defaultPumpTimeout,
  }) async {
    await pumpUntilVisibleAmount(finder, 1, timeout: timeout);
    try {
      await tap(finder);
      await pump();
    }
    // ignore: avoid_catching_errors
    on StateError catch (e) {
      throw TestFailure(e.message);
    }
  }

  /// The function does enterText() and immediately pump()
  /// To remove redundant pump calls() from the steps code
  Future<void> enterTextWithPump(
    Finder finder,
    String text, {
    Duration timeout = _defaultPumpTimeout,
  }) async {
    await pumpUntilVisible(finder, timeout: timeout);
    try {
      await enterText(finder, text);
      await pump();
    }
    // ignore: avoid_catching_errors
    on StateError catch (e) {
      // ignore: only_throw_errors
      throw TestFailure(e.message);
    }
  }

  /// The method that swipes [view] in the direction of [MoveStep] until [finder] is detected
  /// [followUp] does another swipe after the condition is met
  /// [delay] adds a delay after each swipe, because there is a problem with detecting [view] in motion
  Future<void> customDragUntilVisible(
    Finder finder,
    Finder view,
    Offset moveStep, {
    int maxIteration = 50,
    Duration duration = const Duration(milliseconds: 50),
    bool followUp = false,
    Duration delay = const Duration(),
    Finder? errorWidget,
  }) {
    return TestAsyncUtils.guard<void>(() async {
      await pumpUntilVisible(view);
      for (int i = 0; i < maxIteration && finder.evaluate().isEmpty; i++) {
        await dragFrom(getCenter(view), moveStep);
        await pumpUntilSettled(timeout: duration + delay);
        if (errorWidget != null) {
          if (errorWidget.evaluate().isNotEmpty) {
            throw TestFailure('Error was encountered $errorWidget');
          }
        }
      }
      if (followUp) await flingFrom(getCenter(view), moveStep, 5000);
    });
  }

  /// The method that swaps [view] in the direction of [MoveStep] until [finder] disappears from view
  /// [followUp] does another swipe after the condition is met
  /// [delay] adds a delay after each vape, because there is a problem with detecting [view] in motion
  Future<void> customDragUntilNotVisible(
    Finder finder,
    Finder view,
    Offset moveStep, {
    int maxIteration = 50,
    Duration duration = const Duration(milliseconds: 50),
    bool followUp = false,
    Duration delay = const Duration(),
  }) {
    return TestAsyncUtils.guard<void>(() async {
      await pumpUntilVisible(view);
      for (int i = 0; i < maxIteration && finder.evaluate().isNotEmpty; i++) {
        await dragFrom(getCenter(view), moveStep);
        await pumpUntilSettled(timeout: duration + delay);
      }
      if (followUp) await flingFrom(getCenter(view), moveStep, 5000);
    });
  }
}
