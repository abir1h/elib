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
      actionChild: Row(
        children: [
          IconButton(
              onPressed: () {
                // // Check if the note with the same ID exists in the list
                // int existingIndex = controller.noteList.indexWhere(
                //       (note) => note.id == _screenArgs.noteModel?.id!,
                // );
                //
                // if (existingIndex != -1) {
                //   // Replace the existing note with the updated one
                //   controller.noteList[existingIndex] = _screenArgs.noteModel!;
                //   Navigator.of(context).pushNamed(AppRoute.rootScreen,
                //       arguments: RootScreenArgs(index: 2));
                //   // Get.toNamed(AppRoutes.bottomNav, arguments: 2);
                // } else {
                //   // If the note with the ID doesn't exist, add it to the list
                //   controller.noteList.add(_screenArgs.noteModel!);
                //   Navigator.of(context).pushNamed(AppRoute.rootScreen,
                //       arguments: RootScreenArgs(index: 2));
                // }
              },
              icon: Icon(Icons.check,
                  size: size.r24, color: clr.appPrimaryColorGreen)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoute.noteDetailsScreenBeta,
                );
              },
              icon:
                  Icon(Icons.edit, size: size.r24, color: clr.iconColorBlack)),
        ],
      ),
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
