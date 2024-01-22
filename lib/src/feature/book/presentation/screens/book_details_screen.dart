import 'package:cached_network_image/cached_network_image.dart';
import 'package:elibrary/src/core/common_widgets/custom_button.dart';
import 'package:elibrary/src/core/constants/app_theme.dart';
import 'package:elibrary/src/core/routes/app_route_args.dart';
import 'package:elibrary/src/core/toasty.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_routes.dart';
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
                    child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
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
                        // Text("Book Title: ${data.titleEn}"),
                        Text.rich(
                          TextSpan(
                            text: "Book Title: ",
                            children: [
                              TextSpan(
                                text: data.titleEn,
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.textSmall,
                                ),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            color: clr.appPrimaryColorGreen,
                            fontWeight: FontWeight.w900,
                            fontSize: size.textSmall,
                          ),
                        ),
                        SizedBox(
                          height: size.h4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Author Name: ",
                              style: TextStyle(
                                color: clr.textColorAppleBlack,
                                fontWeight: FontWeight.w900,
                                fontSize: size.textXSmall,
                              ),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: data.author
                                    .map((e) => Text(
                                          e.name,
                                          style: TextStyle(
                                            color: clr.textColorAppleBlack,
                                            fontSize: size.textXSmall,
                                          ),
                                        ))
                                    .toList())
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onTap: ()=>onNavigateToBookViewerScreen((widget.arguments as BookDetailsScreenArgs).bookData),
                          title: "Read Book",
                          buttonColor: clr.appPrimaryColorGreen,
                        ),
                        SizedBox(
                          height: size.h8,
                        ),
                        CustomButton(onTap: () {
                          downloadFile( "http://103.209.40.89:82/uploads/${data.bookFile}", filename: data.bookFile.substring(data.bookFile.lastIndexOf("/")+1).replaceAll("?","").replaceAll("=",""));
                        }, title: "Download Book"),
                        SizedBox(
                          height: size.h32,
                        ),
                      ],
                    )
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
  @override
  void navigateToBookViewerScreen(BookDataEntity item) {
    Navigator.of(context).pushNamed(
      AppRoute.bookViewScreen,
      arguments: BookViewerScreenArgs(
        // docId: item.id.toString(),
        title: item.titleEn,
        canDownload: item.isDownload==1?true:false,
        url: "http://103.209.40.89:82/uploads/${item.bookFile}",
      ),
    );
  }

}
