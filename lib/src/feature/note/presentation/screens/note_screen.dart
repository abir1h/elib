import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
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

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>
    with AppTheme, Language, NoteScreenService {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.notesText, b: bn.notesText),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppStreamBuilder<List<NoteDataEntity>>(
                stream: noteDataStreamController.stream,
                loadingBuilder: (context) {
                  return const Center(child: CircularLoader());
                },
                dataBuilder: (context, data) {
                  return NoteItemSectionWidget(
                      items: data,
                      buildItem: (context, index, item) {
                        return NoteItemWidget(
                          noteDataEntity: item,
                          onDelete: () => _onDelete(noteId: item.id!),
                          onPressed: () => onTapNote(item),
                        );
                      });
                },
                emptyBuilder: (context, message, icon) => EmptyWidget(
                  message: message,
                  constraints: constraints,
                  offset: 350.w,
                ),
              ),
            ),
            // SizedBox(height: size.h64),
          ],
        ),
      ),
    );
  }

  void _onDelete({required int noteId}) {
    CustomDialogWidget.show(
            context: context,
            title: "Do you want to delete Notes?",
            infoText: "Are you Sure?")
        .then((x) {
      if (x) {
        onNotesDelete(noteId);
        loadNotesData(true, pageNumber: 1);
      }
    });
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void onNavigateToNoteDetailsScreen(NoteDataEntity noteDataEntity) {
    Navigator.of(context).pushNamed(AppRoute.noteDetailsScreen,
        arguments: NoteDetailsScreenArgs(noteDataEntity: noteDataEntity));
  }
}

class NoteItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const NoteItemSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
  }
}

class NoteItemWidget extends StatelessWidget with AppTheme {
  final NoteDataEntity noteDataEntity;
  final VoidCallback onDelete;
  final VoidCallback onPressed;
  const NoteItemWidget({
    super.key,
    required this.noteDataEntity,
    required this.onDelete,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.h8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: size.w1,
          color: clr.boxStrokeColor,
        ))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(size.r12),
                decoration: BoxDecoration(
                  color: clr.shadeWhiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(size.r10)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  noteDataEntity.note,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                    fontSize: size.textXXSmall,
                    color: clr.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: size.w16),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          noteDataEntity.note,
                          style: TextStyle(
                            color: clr.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: size.textXSmall,
                            fontFamily: StringData.fontFamilyPoppins,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: onDelete,
                        child: Icon(
                          Icons.close,
                          size: size.r24,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.h4),
                  Text(
                    label(
                        e: noteDataEntity.book!.titleEn,
                        b: noteDataEntity.book!.titleEn),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: size.textXXSmall,
                        fontFamily: StringData.fontFamilyPoppins,
                        color: clr.appPrimaryColorGreen),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          "তারিখ: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(noteDataEntity.createdAt!))}",
                          style: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontWeight: FontWeight.w400,
                            fontSize: size.textXXSmall,
                            fontFamily: StringData.fontFamilyPoppins,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
