import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';

class AuthorDetailsScreen extends StatefulWidget {
  const AuthorDetailsScreen({super.key});

  @override
  State<AuthorDetailsScreen> createState() => _AuthorDetailsScreenState();
}

class _AuthorDetailsScreenState extends State<AuthorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "আব্দুল্লাহ আবু সায়ীদ",
        child: LayoutBuilder(
          builder: (context, constraints) => Container(),
        ));
  }
}
