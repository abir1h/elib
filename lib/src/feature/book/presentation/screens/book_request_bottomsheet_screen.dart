import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../services/book_request_bottomsheet_screen_service.dart';
import '../../../../core/common_widgets/custom_action_button.dart';
import '../../domain/entities/book_request_entity.dart';

class BookRequestBottomSheet extends StatefulWidget {
  final BookRequestDataEntity bookRequestDataEntity;
  final VoidCallback onBookRequestSuccess;
  final bool edit;
  const BookRequestBottomSheet({
    super.key,
    required this.bookRequestDataEntity,
    required this.onBookRequestSuccess,
    required this.edit,
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
  void initState() {
    super.initState();
    preFillExistingInfo();
  }

  ///Existing info
  void preFillExistingInfo() {
    authorNameController.text = widget.bookRequestDataEntity.authorName;
    bookNameController.text = widget.bookRequestDataEntity.bookName;
    publishYearController.text = widget.bookRequestDataEntity.publishYear;
    editionController.text = widget.bookRequestDataEntity.edition;
    remarkController.text = widget.bookRequestDataEntity.remark;
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
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h24),
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
                  Text(
                    widget.edit
                        ? label(
                            e: en.updateRequestedBook,
                            b: bn.updateRequestedBook)
                        : label(
                            e: en.requestForNewBook, b: bn.requestForNewBook),
                    style: TextStyle(
                      fontFamily: StringData.fontFamilyPoppins,
                      fontWeight: FontWeight.w600,
                      fontSize: size.textXMedium,
                      color: clr.appSecondaryColorPurple,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: size.h20),
                      color: clr.cardStrokeColor,
                      height: size.h1),
                  AppTextFieldWithTitle(
                    title: label(e: en.bookName, b: bn.bookName),
                    hintText: label(e: en.bookNameHint, b: bn.bookNameHint),
                    controller: bookNameController,
                  ),
                  SizedBox(height: size.h8),
                  AppTextFieldWithTitle(
                    title: label(e: en.authorName, b: bn.authorName),
                    hintText: label(e: en.authorNameHint, b: bn.authorNameHint),
                    controller: authorNameController,
                  ),
                  SizedBox(height: size.h8),
                  AppTextFieldWithTitle(
                    title: label(e: en.publishYear, b: bn.publishYear),
                    hintText:
                        label(e: en.publishYearHint, b: bn.publishYearHint),
                    controller: publishYearController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: size.h8),
                  AppTextFieldWithTitle(
                    title: label(e: en.edition, b: bn.edition),
                    hintText: label(e: en.editionHint, b: bn.editionHint),
                    controller: editionController,
                  ),
                  SizedBox(height: size.h8),
                  AppTextFieldWithTitle(
                    title: label(e: en.remark, b: bn.remark),
                    hintText: label(e: en.remark, b: bn.remark),
                    controller: remarkController,
                  ),
                  SizedBox(height: size.h16),
                  CustomActionButton(
                      title: widget.edit
                          ? label(
                              e: en.updateRequestBook, b: bn.updateRequestBook)
                          : label(e: en.requestBook, b: bn.requestBook),
                      onSuccess: (e) {
                        widget.onBookRequestSuccess();
                      },
                      onCheck: () => validateFormData(
                          authorNameController,
                          bookNameController,
                          publishYearController,
                          editionController),
                      tapAction: () => onBookRequestOrUpdate(
                            item: BookRequestDataEntity(
                                id: widget.edit
                                    ? widget.bookRequestDataEntity.id
                                    : null,
                                emisUserId: 1,
                                authorName: authorNameController.text.trim(),
                                bookName: bookNameController.text.trim(),
                                publishYear: publishYearController.text.trim(),
                                edition: editionController.text.trim(),
                                remark: remarkController.text.trim()),
                            edit: widget.edit,
                          )),
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
