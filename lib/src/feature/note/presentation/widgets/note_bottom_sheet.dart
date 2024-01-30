import 'dart:convert';

import 'package:elibrary/src/core/utility/log.dart';
import 'package:elibrary/src/feature/book/presentation/services/book_view_screen_service.dart';
import 'package:elibrary/src/feature/note/data/models/note_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/note_data_entity.dart';

class NoteBottomSheet extends StatefulWidget {
  final NoteDataEntity? noteDataEntity;


  const NoteBottomSheet({
    super.key,
    this.noteDataEntity,
  });

  @override
  State<NoteBottomSheet> createState() => _NoteBottomSheetState();
}

class _NoteBottomSheetState extends State<NoteBottomSheet>
    with AppTheme, Language, BookViewerScreenService {

  final HtmlEditorController controller = HtmlEditorController();
  bool isKeyboardOpen = false;

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: .3.sh),
            padding: EdgeInsets.only(top: size.h10, right: size.w16, left: 20),
            decoration: BoxDecoration(
              color: clr.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.w12),
                topRight: Radius.circular(size.w12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.getText().then((value) => onCreateNotes(NoteDataEntity(
                          id: widget.noteDataEntity?.id,
                          bookId: widget.noteDataEntity!.bookId,
                          emisUserId: widget.noteDataEntity!.emisUserId,
                          note: value,
                        )));
                        Navigator.pop(context);
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
                  ],
                ),
                Expanded(
                  child: HtmlEditor(
                    controller: controller,
                    //required
                    htmlEditorOptions: HtmlEditorOptions(
                        autoAdjustHeight: false,
                        hint: "Your text here...",
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
            )
          ),
        ),
      ),
    );
  }

  @override
  void forceClose() {
    Navigator.of(context).pop();
  }

  @override
  void showWarning(String msg) {
    CustomToasty.of(context).showWarning(msg);
  }

  @override
  void showSuccess(String msg) {
    CustomToasty.of(context).showSuccess(msg);
  }
}
