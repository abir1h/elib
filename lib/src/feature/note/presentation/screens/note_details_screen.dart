import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const NoteDetailsScreen({super.key, this.arguments});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen>
    with AppTheme, Language {
  late NoteDetailsScreenArgs _screenArgs;
  final HtmlEditorController controller = HtmlEditorController();

  @override
  void initState() {
    _screenArgs = widget.arguments as NoteDetailsScreenArgs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AppRoute.noteDetailsScreenBeta,
                          arguments: NoteDetailsScreenArgs(
                              noteDataEntity: _screenArgs.noteDataEntity));
                    },
                    icon: Icon(Icons.edit,
                        size: size.r24, color: clr.iconColorBlack)),
              ],
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
                    disabled: true,
                    initialText: _screenArgs.noteDataEntity.note
                    //initalText: "text content initial, if any",
                    ),

                htmlToolbarOptions: const HtmlToolbarOptions(
                    toolbarPosition: ToolbarPosition.belowEditor,
                    defaultToolbarButtons: []),
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
  }
}
