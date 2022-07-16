import 'dart:async';

class DateTimeStream {
  final StreamController<DateTime?> _controller =
      StreamController<DateTime?>.broadcast();
  StreamSink<DateTime?> get sink => _controller.sink;
  Stream<DateTime?> get stream => _controller.stream;

  dispose() => _controller.close();
}
