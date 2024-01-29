import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

abstract class _ViewModel {}

mixin NoteService<T extends StatefulWidget> on State<T> implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;

    super.initState();
  }
}
