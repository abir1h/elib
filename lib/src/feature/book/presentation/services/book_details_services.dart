import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../domain/entities/book_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../book/data/data_sources/remote/book_data_source.dart';
import '../../../book/data/repositories/book_repository_imp.dart';
import '../../../book/domain/use_cases/book_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import 'book_view_screen_service.dart';

abstract class _ViewModel {
  void showSuccess(String message);
  void showWarning(String message);
  void navigateToBookViewerScreen(BookDataEntity bookData);
}

mixin BookDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
          BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> getBookDetails(int bookId) async {
    return _bookUseCase.getBookDetailsUseCase(bookId);
  }

  Future<ResponseEntity> bookmarkBookAction(
      {required int bookId, required int eMISUserId}) async {
    return _bookUseCase.bookmarkUseCase(bookId, eMISUserId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<BookDataEntity> bookDataStreamController =
      AppStreamController();
  int _readingTime = 0;
  Timer? _timer;
  final StreamController<PageState> _pageStateStreamController =
      StreamController.broadcast();
  Stream<PageState> get pageStateStream => _pageStateStreamController.stream;
  Sink<PageState>? get _pageStateSink => !_pageStateStreamController.isClosed
      ? _pageStateStreamController.sink
      : null;

  final StreamController<String> _loadingProgressStreamController =
      StreamController.broadcast();
  Stream<String> get loadingProgressStream =>
      _loadingProgressStreamController.stream;
  Sink<String>? get _loadingProgressSink =>
      !_loadingProgressStreamController.isClosed
          ? _loadingProgressStreamController.sink
          : null;

  final StreamController<String> _loadingSizeStreamController =
      StreamController.broadcast();
  Stream<String> get loadingSizeStream => _loadingSizeStreamController.stream;
  Sink<String>? get _loadingSizeSink => !_loadingSizeStreamController.isClosed
      ? _loadingSizeStreamController.sink
      : null;

  late BookDataEntity bookData;

  ///Load Book list
  void loadInitialData(BookDetailsScreenArgs args) {
    ///Loading state
    if (!mounted) return;
    bookDataStreamController.add(LoadingState());
    getBookDetails(args.bookData.id).then((value) {
      if (value.error == null && value.data != null) {
        bookData = value.data!;
        bookDataStreamController
            .add(DataLoadedState<BookDataEntity>(value.data!));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onBookmarkContentSelected(BookDataEntity item) {
    bookmarkBookAction(
      bookId: item.id,
      eMISUserId: 1,
    ).then((value) {
      if (value.error == null && value.data != null) {
        bookData.bookMark = !bookData.bookMark;
        bookDataStreamController.add(DataLoadedState<BookDataEntity>(bookData));
        _view.showSuccess(item.bookMark
            ? "বুকমার্ক সফলভাবে যোগ করা হয়েছে !"
            : "বুকমার্ক সফলভাবে মুছে ফেলা হয়েছে !");
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onNavigateToBookViewerScreen(BookDataEntity item) {
    _view.navigateToBookViewerScreen(item);
  }

  void downloadBook(BookDataEntity item) {}

  void downloadFile(String url, {required String filename}) async {
    CustomToasty.of(context).lockUI();
    try {
      var httpClient = http.Client();
      var request = http.Request('GET', Uri.parse(url));
      // request.headers.addAll({"Authorization": "${App.currentSession.tokenType} ${App.currentSession.accessToken}"},);
      var response = httpClient.send(request);
      String dir = (await getTemporaryDirectory()).path;

      List<List<int>> chunks = [];
      int downloaded = 0;

      ///Reset timer
      _timer?.cancel();
      _readingTime = 0;

      response.asStream().listen(
        (http.StreamedResponse r) {
          r.stream.listen(
            (List<int> chunk) {
              chunks.add(chunk);
              downloaded += chunk.length;

              if ((downloaded / r.contentLength! * 100).floor() == 100) {
                _loadingProgressSink?.add('Loading complete');
              } else {
                _loadingProgressSink?.add('Loading..');
              }

              _loadingSizeSink?.add(formatBytes(downloaded, 2));
            },
            onDone: () async {
              /// Save the file
              File file = File('$dir/$filename');

              final Uint8List bytes = Uint8List(r.contentLength!);
              int offset = 0;
              for (List<int> chunk in chunks) {
                bytes.setRange(offset, offset + chunk.length, chunk);
                offset += chunk.length;
              }
              await file.writeAsBytes(bytes);

              ///Get mime type and if it is PDF file then render to ui, otherwise show unknown file preview
              if ((lookupMimeType(filename) ?? "").toLowerCase() ==
                  "application/pdf") {
                ///PDF File loaded to screen
                if (!_pageStateStreamController.isClosed) {
                  _pageStateSink?.add(PdfLoadedState(
                      file, bookData.isDownload == 1 ? true : false));

                  ///Start timer
                  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                    _readingTime += 1;
                  });
                }
              } else {
                ///Unknown File loaded to screen
                if (!_pageStateStreamController.isClosed) {
                  _pageStateSink
                      ?.add(UnknownFileLoadedState(file, bookData.titleEn));
                }
              }
              CustomToasty.of(context).releaseUI();
              onSaveFileToLocalStorage(file);
              return;
            },
            onError: _onDownloadFailed,
          );
        },
        onError: _onDownloadFailed,
      );
    } catch (e) {
      _onDownloadFailed("");
    }
  }

  void _onDownloadFailed(dynamic x) {
    if (!_pageStateStreamController.isClosed) {
      _pageStateSink?.add(ErrorState("Download failed!",
          "Something error occurred while downloading your requested file."));
    }
  }

  void onSaveFileToLocalStorage(File file, [bool restartTimer = false]) async {
    if (Platform.isAndroid) {
      await saveFileToAndroidStorage(file: file);
    } else if (Platform.isIOS) {
      await saveFileToiOSStorage(file: file);
    }

    // ///Start timer if the file is not pdf file
    // if(restartTimer){
    //   _timer?.cancel();
    //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //     _readingTime += 1;
    //   });
    // }
  }

  Future<void> saveFileToAndroidStorage({
    required File file,
  }) async {
    try {
      if (((await DeviceInfoPlugin().androidInfo).version.sdkInt ?? 0) < 30) {
        if (!(await Permission.storage.request()).isGranted) {
          _view.showWarning("Storage permission denied!");
          return;
        }
      }
      final Saf _saf = Saf("~/");
      await _saf.clearCache();
      List<String>? persistedDirs;
      bool? isGranted = await _saf.getDirectoryPermission(
          grantWritePermission: true, isDynamic: true);
      if (isGranted != null && isGranted) {
        persistedDirs = await Saf.getPersistedPermissionDirectories();
      } else {
        return;
      }

      persistedDirs?.forEach((path) async {
        var _localStorage = "/storage/emulated";
        var _userIndex = "0";
        await getExternalStorageDirectory().then((d) {
          if (d != null &&
              d.path.toLowerCase().contains("/storage/emulated/")) {
            _userIndex = d.path.substring(18, 19);
          }
        }).catchError((_) {});

        await file
            .copy(
                "$_localStorage/$_userIndex/$path/${file.path.split("/").last}")
            .then((value) {
          // _view.showSuccess("File saved successfully!");
        }).catchError((error) async {
          _view.showWarning(
              'Unable to save to this directory! Please select "Documents" directory.');
        });
      });
      await _saf.releasePersistedPermission();
    } catch (_) {}
  }

  Future<void> saveFileToiOSStorage({
    required File file,
  }) async {
    await getApplicationDocumentsDirectory().then((directory) async {
      await Share.shareFilesWithResult([file.path]).then((value) {
        if (value.status == ShareResultStatus.unavailable) {
          _view.showWarning("Unable to save file!");
        }
      }).catchError((error) {
        _view.showWarning("Unable to save file!");
      });
    }).catchError((_) {
      _view.showWarning("Unable to save file!");
    });
  }
}
