/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../services/note_screen_service.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../domain/entities/note_data_entity.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../services/note_service.dart';

class NoteScreenBeta extends StatefulWidget {
  const NoteScreenBeta({super.key});

  @override
  State<NoteScreenBeta> createState() => _NoteScreenBetaState();
}

class _NoteScreenBetaState extends State<NoteScreenBeta>
    with AppTheme, Language, NoteService {
  late QuillEditorController controller;

  bool isKeyboardOpen = false;
  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.underline,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.align,
  ];
  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    // Initialize QuillEditorController in initState
    controller = QuillEditorController();
    // Set up listeners
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    controller.onEditorLoaded(() {
      debugPrint('Editor Loaded :)');
    });
  }

  @override
  void dispose() {
    // Dispose QuillEditorController in dispose
    controller.dispose();
    super.dispose();
  }

  void unFocusEditor() {
    // Check if the editor has focus before calling unFocus
    if (_hasFocus) {
      controller.unFocus();
    }
  }

  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText);
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }

  ///[insertVideoURL] to set the video url to editor
  ///this method recognises the inserted url and sanitize to make it embeddable url
  ///eg: converts youtube video to embed video, same for vimeo
  void insertVideoURL(String url) async {
    await controller.embedVideo(url);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await controller.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            label(e: en.notesText, b: bn.notesText),
          ),
        ),
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              QuillHtmlEditor(
                text: "<h1>Hello</h1>This is a quill html editor example 😊",
                hintText: 'Hint text goes here',
                controller: controller,
                isEnabled: true,
                ensureVisible: true,
                minHeight: 500,
                autoFocus: true,
                textStyle: _editorTextStyle,
                hintTextStyle: _hintTextStyle,
                hintTextAlign: TextAlign.start,
                padding: const EdgeInsets.only(left: 10, top: 10),
                hintTextPadding: const EdgeInsets.only(left: 20),
                backgroundColor: _backgroundColor,
                inputAction: InputAction.newline,
                onEditingComplete: (s) => debugPrint('Editing completed $s'),
                loadingBuilder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Colors.red,
                    ),
                  );
                },
                onFocusChanged: (focus) {
                  debugPrint('has focus $focus');
                  setState(() {
                    _hasFocus = focus;
                  });
                },
                onTextChanged: (text) => debugPrint('widget text change $text'),
                onEditorCreated: () {},
                onEditorResized: (height) =>
                    debugPrint('Editor resized $height'),
                onSelectionChanged: (sel) =>
                    debugPrint('index ${sel.index}, range ${sel.length}'),
              ),
              if (isKeyboardOpen)
                Positioned(
                  bottom: 0,
                  child: ToolBar(
                    mainAxisSize: MainAxisSize.min,
                    toolBarColor: _toolbarColor,
                    padding: const EdgeInsets.all(8),
                    iconSize: 25,
                    iconColor: _toolbarIconColor,
                    activeIconColor: clr.appPrimaryColorGreen,
                    controller: controller,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    // toolBarConfig: customToolBarList,
                  ),
                )
            ],
          ),
        ));
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void onNavigateToNoteDetailsScreen(NoteDataEntity noteDataEntity) {
    Navigator.of(context).pushNamed(AppRoute.noteDetailsScreen,
        arguments: NoteDetailsScreenArgs(noteDataEntity: noteDataEntity));
  }
}
*/

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/note_data_entity.dart';
import '../services/note_edit_screen_service.dart';
import '../../../../core/routes/app_routes.dart';

class NoteScreenBeta extends StatefulWidget {
  final Object? arguments;
  const NoteScreenBeta({super.key, this.arguments});

  @override
  State<NoteScreenBeta> createState() => _NoteScreenBetaState();
}

class _NoteScreenBetaState extends State<NoteScreenBeta>
    with AppTheme, Language, NoteEditScreenService {
  final HtmlEditorController controller = HtmlEditorController();
  bool isKeyboardOpen = false;
  late NoteDetailsScreenArgs _screenArgs;

  @override
  void initState() {
    _screenArgs = widget.arguments as NoteDetailsScreenArgs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            label(e: en.notesText, b: bn.notesText),
            style: TextStyle(
                color: clr.appPrimaryColorGreen,
                fontSize: size.textXMedium,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  controller
                      .getText()
                      .then((value) => onUpdateNotes(NoteDataEntity(
                            id: _screenArgs.noteDataEntity.id,
                            bookId: _screenArgs.noteDataEntity.bookId,
                            emisUserId: _screenArgs.noteDataEntity.emisUserId,
                            note: value,
                          )));
                  Navigator.popAndPushNamed(context, AppRoute.noteScreen);
                },
                child: Container(
                  padding: EdgeInsets.all(size.r4),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(size.r8),
                      color: clr.appPrimaryColorGreen),
                  child: Icon(
                    Icons.check,
                    color: clr.whiteColor,
                    size: size.r24,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: HtmlEditor(
                controller: controller,
                //required
                htmlEditorOptions: HtmlEditorOptions(
                    autoAdjustHeight: false,
                    hint: "Your text here...",
                    initialText: _screenArgs.noteDataEntity.note
                    //initalText: "text content initial, if any",
                    ),

                htmlToolbarOptions: HtmlToolbarOptions(
                    toolbarPosition: ToolbarPosition.belowEditor,
                    defaultToolbarButtons: [
                      const FontButtons(
                          bold: true,
                          italic: true,
                          underline: true,
                          strikethrough: false,
                          clearAll: false,
                          subscript: false,
                          superscript: false),
                      const ColorButtons(),
                      const ListButtons(listStyles: false),
                      const ParagraphButtons(
                          textDirection: false,
                          lineHeight: false,
                          caseConverter: false,
                          alignCenter: true,
                          alignJustify: true,
                          alignLeft: true,
                          alignRight: true,
                          decreaseIndent: false,
                          increaseIndent: false),
                    ]),
                otherOptions: OtherOptions(
                  decoration: BoxDecoration(color: clr.whiteColor
                      // color: Colors.red
                      ),
                  height: 1.sh,
                ),
              ),
            ),
          ],
        ));
    // body: SizedBox(
    //   height: 1.sh,
    //   width: 1.sw,
    //   child: Stack(
    //     clipBehavior: Clip.none,
    //     children: [
    //       QuillHtmlEditor(
    //         text: "<h1>Hello</h1>This is a quill html editor example 😊",
    //         hintText: 'Hint text goes here',
    //         controller: controller,
    //         isEnabled: true,
    //         ensureVisible: true,
    //         minHeight: 500,
    //         autoFocus: true,
    //         textStyle: _editorTextStyle,
    //         hintTextStyle: _hintTextStyle,
    //         hintTextAlign: TextAlign.start,
    //         padding: const EdgeInsets.only(left: 10, top: 10),
    //         hintTextPadding: const EdgeInsets.only(left: 20),
    //         backgroundColor: _backgroundColor,
    //         inputAction: InputAction.newline,
    //         onEditingComplete: (s) => debugPrint('Editing completed $s'),
    //         loadingBuilder: (context) {
    //           return const Center(
    //             child: CircularProgressIndicator(
    //               strokeWidth: 1,
    //               color: Colors.red,
    //             ),
    //           );
    //         },
    //         onFocusChanged: (focus) {
    //           debugPrint('has focus $focus');
    //           setState(() {
    //             _hasFocus = focus;
    //           });
    //         },
    //         onTextChanged: (text) => debugPrint('widget text change $text'),
    //         onEditorCreated: () {},
    //         onEditorResized: (height) =>
    //             debugPrint('Editor resized $height'),
    //         onSelectionChanged: (sel) =>
    //             debugPrint('index ${sel.index}, range ${sel.length}'),
    //       ),
    //       if (isKeyboardOpen)
    //         Positioned(
    //           bottom: 0,
    //           child: ToolBar(
    //             mainAxisSize: MainAxisSize.min,
    //             toolBarColor: _toolbarColor,
    //             padding: const EdgeInsets.all(8),
    //             iconSize: 25,
    //             iconColor: _toolbarIconColor,
    //             activeIconColor: clr.appPrimaryColorGreen,
    //             controller: controller,
    //             crossAxisAlignment: WrapCrossAlignment.start,
    //             direction: Axis.horizontal,
    //             toolBarConfig: customToolBarList,
    //           ),
    //         )
    //     ],
    //   ),
    // ));
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
