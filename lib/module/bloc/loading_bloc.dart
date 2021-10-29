import 'dart:async';

class LoadingBloc {
  final StreamController<bool> _loadingcontroller = StreamController<bool>();
  StreamSink<bool> get loadingsink => _loadingcontroller.sink;
  Stream<bool> get loadingstrim => _loadingcontroller.stream;

  void dispose() {
    _loadingcontroller.close();
  }
}
