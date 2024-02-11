import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/language.dart';
import 'author_screen.dart';
import '../widgets/author_book_widget.dart';

class AuthorDetailsScreen extends StatefulWidget {
  const AuthorDetailsScreen({super.key});

  @override
  State<AuthorDetailsScreen> createState() => _AuthorDetailsScreenState();
}

class _AuthorDetailsScreenState extends State<AuthorDetailsScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "আব্দুল্লাহ আবু সায়ীদ",
        child: LayoutBuilder(
            builder: (context, constraints) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w16, vertical: size.h16),
                  child: AppScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // AuthorItemWidget(
                        //   onTap: () {},
                        // ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.5,
                            crossAxisSpacing: size.h12,
                            mainAxisSpacing: size.h12,
                          ),
                          itemCount: 15,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: size.h20),
                          itemBuilder: (context, index) {
                            return AuthorBookWidget();
                          },
                        )
                      ],
                    ),
                  ),
                )));
  }
}
