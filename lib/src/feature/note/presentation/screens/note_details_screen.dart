import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../services/note_details_screen_service.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../domain/entities/note_data_entity.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const NoteDetailsScreen({super.key, this.arguments});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen>
    with AppTheme, Language, AppEventsNotifier, NoteDetailsScreenService {
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
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back,
              color: clr.appPrimaryColorBlack,
              size: size.r24,
            ),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () => onTapEdit(_screenArgs.noteDataEntity),
                    icon: Icon(Icons.edit,
                        size: size.r24, color: clr.iconColorBlack)),
              ],
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(color: clr.cardStrokeColor, height: size.h1),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label(
                          e: _screenArgs.noteDataEntity.book!.titleEn,
                          b: _screenArgs.noteDataEntity.book!.titleEn),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.textSmall,
                          fontFamily: StringData.fontFamilyPoppins,
                          color: clr.appSecondaryColorPurple),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        onTapBookName(_screenArgs.noteDataEntity.book!),
                    child: Icon(
                      Icons.arrow_forward,
                      size: size.r24,
                      color: clr.appSecondaryColorPurple,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                    autoAdjustHeight: false,
                    hint: "Your text here...",
                    disabled: true,
                    initialText: _screenArgs.noteDataEntity.note),
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

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.notes) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void onNavigateToBookDetailsScreen(BookDataEntity bookDataEntity) {
    Navigator.of(context).pushNamed(AppRoute.bookDetailsScreen,
        arguments: BookDetailsScreenArgs(bookData: bookDataEntity));
  }

  @override
  void onNavigateToNoteEditScreen(NoteDataEntity noteDataEntity) {
    Navigator.of(context).pushNamed(AppRoute.noteDetailsScreenBeta,
        arguments: NoteDetailsScreenArgs(noteDataEntity: noteDataEntity));
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
