import 'dart:async';

class StringStream {
  final StreamController<String?> _controller = StreamController<String?>();
  StreamSink<String?> get sink => _controller.sink;
  Stream<String?> get stream => _controller.stream;

  dispose() => _controller.close();
}
