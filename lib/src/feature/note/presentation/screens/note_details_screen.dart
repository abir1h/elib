import 'dart:convert';

import 'package:elibrary/src/feature/book/domain/entities/book_data_entity.dart';
import 'package:elibrary/src/feature/note/domain/entities/note_data_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/routes/app_routes.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const NoteDetailsScreen({super.key, this.arguments});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> with AppTheme {
  late NoteDetailsScreenArgs _screenArgs;

  @override
  void initState() {
    _screenArgs = widget.arguments as NoteDetailsScreenArgs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      actionChild: IconButton(
          onPressed: () {
            String noteJson = jsonEncode([
              {"insert": "Your "},
              {
                "insert":
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc",
                "attributes": {"italic": true, "underline": true}
              },
              {
                "insert":
                    " There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc\n"
              }
            ]);
            Navigator.of(context).pushNamed(AppRoute.noteEditScreen,
                arguments: NoteDetailsScreenArgs(
                    noteDataEntity: NoteDataEntity(
                  id: _screenArgs.noteDataEntity.id,
                  bookId: _screenArgs.noteDataEntity.bookId,
                  emisUserId: _screenArgs.noteDataEntity.emisUserId,
                  note: noteJson,
                )));
          },
          icon: Icon(Icons.edit, size: size.r24, color: clr.iconColorBlack)),
      child: LayoutBuilder(
        builder: (context, constraints) => AppScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_screenArgs.noteDataEntity.note),
            ],
          ),
        ),
      ),
    );
  }
}
