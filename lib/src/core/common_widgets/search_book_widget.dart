import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import '../constants/app_theme.dart';

class SearchBoxWidget extends StatefulWidget{
  final String hintText;
  final void Function(String value) onSearchTermChange;
  // final ServiceState serviceState;
  const SearchBoxWidget({Key? key, required this.hintText,required this.onSearchTermChange,
    // required  this.serviceState
  }) : super(key: key);

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}
class _SearchBoxWidgetState extends State<SearchBoxWidget>  with AppTheme {
  final TextEditingController _textEditingController = TextEditingController();
  late BehaviorSubject<String> _searchSubject;
  StreamSubscription<String>? _subscription;


  @override
  void initState() {
    _searchSubject = BehaviorSubject<String>();
    _subscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 300))
        .listen(widget.onSearchTermChange);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _searchSubject.close();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: size.h42,
      padding: EdgeInsets.symmetric(horizontal: size.h12, vertical: size.h4),
      decoration: BoxDecoration(
        color: clr.whiteColor,
        border: Border.all(
          color: clr.appPrimaryColorGreen,
          // width: 1.w,
        ),
        borderRadius: BorderRadius.circular(size.h24),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 2.0.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.0.w),
              child: Icon(
                Icons.search_rounded,
                color: clr.blackColor,
                size: size.h20,
              )
            ),
            SizedBox(width: size.h8,),
            Expanded(
              child: TextField(
                controller: _textEditingController,
                maxLines: 1,
                minLines: 1,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  color: clr.blackColor,
                  fontSize: size.textSmall,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.all(0),
                  hintStyle: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                  ),
                ),
                onChanged: _onTextChange,
              ),
            ),
            if(_textEditingController.text.isNotEmpty)
              GestureDetector(
                onTap: (){
                  _textEditingController.clear();
                  _onTextChange(_textEditingController.text);
                },
                child: Icon(
                  Icons.close,
                  color: clr.appSecondaryColorFlagRed,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onTextChange(String value) {
    if(mounted && !_searchSubject.isClosed){
      setState(() {debugPrint("StateUpdated");});
      // widget.serviceState.searchTerm = value;
      _searchSubject.add(value);
    }
  }
}