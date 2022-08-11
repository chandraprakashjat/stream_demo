import 'dart:async';

class NumberController {
  final _controller = StreamController<int>();

  NumberController() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _controller.sink.add(_count);
      _count++;

      if (_count == 5) {
        _controller.close();
        timer.cancel();
      }
    });
  }

  int _count = 0;

  Stream<int> get stream => _controller.stream.asBroadcastStream();
}
