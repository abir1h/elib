import 'package:cached_network_image/cached_network_image.dart';
import 'package:elibrary/src/core/common_widgets/custom_button.dart';
import 'package:elibrary/src/core/constants/app_theme.dart';
import 'package:elibrary/src/core/routes/app_route_args.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../domain/entities/book_data_entity.dart';
import '../services/book_details_services.dart';

class BookDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const BookDetailsScreen({super.key, this.arguments});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with AppTheme, BookDetailsScreenService {
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
      child: AppStreamBuilder<BookDataEntity>(
        stream: bookDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(
            child: CircularLoader(),
          );
        },
        dataBuilder: (context, data) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.h16),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.h56, vertical: size.h24),
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://103.209.40.89:82/uploads/${data.coverImage}",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Text("Book Title: ${data.titleEn}"),
                    SizedBox(
                      height: size.h4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Author Name: "),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                data.author.map((e) => Text(e.name)).toList())
                      ],
                    ),
                    Spacer(),
                    CustomButton(onTap: () {}, title: "Read Book"),
                    SizedBox(
                      height: size.h8,
                    ),
                    CustomButton(onTap: () {}, title: "Download Book"),
                    SizedBox(
                      height: size.h32,
                    ),
                  ],
                ))
              ],
            ),
          );
        },
        emptyBuilder: (context, message, _) => const Offstage(),
      ),
    );
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}
