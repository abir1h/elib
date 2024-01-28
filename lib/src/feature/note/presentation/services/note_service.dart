import 'package:flutter/material.dart';


abstract class _ViewModel {}

mixin NoteScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;



  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Stream controllers
/*  final AppStreamController<BookDataEntity> bookDataStreamController =
  AppStreamController();
  int _readingTime = 0;
  Timer? _timer;
  final StreamController<PageState> _pageStateStreamController =
  StreamController.broadcast();
  Stream<PageState> get pageStateStream => _pageStateStreamController.stream;
  Sink<PageState>? get _pageStateSink => !_pageStateStreamController.isClosed
      ? _pageStateStreamController.sink
      : null;

  final StreamController<String> _loadingProgressStreamController =
  StreamController.broadcast();
  Stream<String> get loadingProgressStream =>
      _loadingProgressStreamController.stream;
  Sink<String>? get _loadingProgressSink =>
      !_loadingProgressStreamController.isClosed
          ? _loadingProgressStreamController.sink
          : null;

  final StreamController<String> _loadingSizeStreamController =
  StreamController.broadcast();
  Stream<String> get loadingSizeStream => _loadingSizeStreamController.stream;
  Sink<String>? get _loadingSizeSink => !_loadingSizeStreamController.isClosed
      ? _loadingSizeStreamController.sink
      : null;

  late BookDataEntity bookData;*/

  ///Load Book list
}
