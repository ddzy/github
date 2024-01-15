import 'dart:async';

class $Debounce {
  $Debounce({
    this.delay = const Duration(milliseconds: 100),
  });

  Duration delay;
  Timer? _timer;

  void run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}
