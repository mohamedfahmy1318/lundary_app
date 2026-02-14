import 'dart:async';

/// Debouncer for search and text input
///
/// Usage:
///   final _debouncer = Debouncer();
///
///   onChanged: (value) {
///     _debouncer.run(() {
///       cubit.search(value);
///     });
///   }
///
///   // Don't forget to dispose:
///   _debouncer.dispose();
class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({this.duration = const Duration(milliseconds: 500)});

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
