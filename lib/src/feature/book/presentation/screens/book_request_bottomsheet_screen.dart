import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../services/book_request_bottomsheet_screen_service.dart';
import '../../../../core/common_widgets/custom_action_button.dart';
import '../../domain/entities/book_request_entity.dart';

class BookRequestBottomSheet extends StatefulWidget {
  final VoidCallback onBookRequestSuccess;
  const BookRequestBottomSheet({
    super.key,
    required this.onBookRequestSuccess,
  });

  @override
  State<BookRequestBottomSheet> createState() => _DiscussionBottomSheetState();
}

class _DiscussionBottomSheetState extends State<BookRequestBottomSheet>
    with AppTheme, Language, BookRequestBottomSheetScreenService {
  TextEditingController authorNameController = TextEditingController();
  TextEditingController bookNameController = TextEditingController();
  TextEditingController publishYearController = TextEditingController();
  TextEditingController editionController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

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
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
            decoration: BoxDecoration(
              color: clr.shadeWhiteColor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.r12),
                topRight: Radius.circular(size.w12),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    hintText: label(e: en.authorName, b: bn.authorName),
                    controller: authorNameController,
                  ),
                  SizedBox(height: size.h8),
                  AppTextField(
                    hintText: label(e: en.bookName, b: bn.bookName),
                    controller: bookNameController,
                  ),
                  SizedBox(height: size.h8),
                  AppTextField(
                    hintText: label(e: en.publishYear, b: bn.publishYear),
                    controller: publishYearController,
                  ),
                  SizedBox(height: size.h8),
                  AppTextField(
                    hintText: label(e: en.edition, b: bn.edition),
                    controller: editionController,
                  ),
                  SizedBox(height: size.h8),
                  AppTextField(
                    hintText: label(e: en.remark, b: bn.remark),
                    controller: remarkController,
                  ),
                  SizedBox(height: size.h16),
                  CustomActionButton(
                      title: label(e: en.requestBook, b: bn.requestBook),
                      onSuccess: (e) {
                        widget.onBookRequestSuccess();
                      },
                      tapAction: () => onBookRequest(BookRequestDataEntity(
                          emisUserId: 1,
                          authorName: authorNameController.text,
                          bookName: bookNameController.text,
                          publishYear: publishYearController.text,
                          edition: editionController.text,
                          remark: remarkController.text))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}