
import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
enum CheckBoxSelection { all, book, author, tag, category }

class CheckBoxWidget extends StatefulWidget {
  final void Function(CheckBoxSelection) onValueChanged;

  const CheckBoxWidget({Key? key, required this.onValueChanged})
      : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget>
    with AppTheme, Language {
  CheckBoxSelection _selectedValue=CheckBoxSelection.all;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<CheckBoxSelection>(
            contentPadding: EdgeInsets.zero,
            activeColor: clr.appSecondaryColorPurple,

            title: Text(label(e: en.checkBoxAll, b: bn.checkBoxAll),style: TextStyle(fontWeight: FontWeight.w500,fontSize: size.textXSmall,fontFamily: StringData.fontFamilyPoppins),),
            value: CheckBoxSelection.all,
            groupValue: _selectedValue,
            onChanged: (CheckBoxSelection? value) {
              setState(() {
                _selectedValue = value!;
                widget.onValueChanged(value);
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<CheckBoxSelection>(
            contentPadding: EdgeInsets.zero,
            activeColor: clr.appSecondaryColorPurple,
            title: Text(label(e: en.checkBoxBook, b: bn.checkBoxBook),style: TextStyle(fontWeight: FontWeight.w500,fontSize: size.textXSmall,fontFamily: StringData.fontFamilyPoppins)),
            value: CheckBoxSelection.book,
            groupValue: _selectedValue,
            onChanged: (CheckBoxSelection? value) {
              setState(() {
                _selectedValue = value!;
                widget.onValueChanged(value);
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<CheckBoxSelection>(
            contentPadding: EdgeInsets.zero,
            activeColor: clr.appSecondaryColorPurple,
            title: Text(label(e: en.checkBoxAuthor, b: bn.checkBoxAuthor),style: TextStyle(fontWeight: FontWeight.w500,fontSize: size.textXSmall,fontFamily: StringData.fontFamilyPoppins)),
            value: CheckBoxSelection.author,
            groupValue: _selectedValue,
            onChanged: (CheckBoxSelection? value) {
              setState(() {
                _selectedValue = value!;
                widget.onValueChanged(value);
              });
            },
          ),
        ),
      ],
    );
  }
}
