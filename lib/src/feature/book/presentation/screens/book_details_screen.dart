import 'package:elibrary/src/core/constants/app_theme.dart';
import 'package:elibrary/src/core/routes/app_route_args.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../services/book_details_services.dart';

class BookDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const BookDetailsScreen({super.key, this.arguments});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> with AppTheme,BookDetailsScreenService {

  @override
  void initState() {
    super.initState();
    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(widget.arguments as BookDetailsScreenArgs);
    });
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Book Details',
      child: Container(),
    );
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}
