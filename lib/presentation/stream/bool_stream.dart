import 'dart:async';

class BoolStream {
  final StreamController<bool> _controller = StreamController<bool>();
  StreamSink<bool> get sink => _controller.sink;
  Stream<bool> get stream => _controller.stream;

  dispose() => _controller.close();
}
