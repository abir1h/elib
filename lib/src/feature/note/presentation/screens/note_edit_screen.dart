import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/note_data_entity.dart';
import '../services/note_edit_screen_service.dart';

class NoteEditScreen extends StatefulWidget {
  final Object? arguments;
  const NoteEditScreen({super.key, this.arguments});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen>
    with AppTheme, Language, NoteEditScreenService {
  late NoteDetailsScreenArgs _screenArgs;
  final _controller = QuillController.basic();
  final _editorFocusNode = FocusNode();
  final _editorScrollController = ScrollController();
  final _isReadOnly = false;
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    _screenArgs = widget.arguments as NoteDetailsScreenArgs;
    super.initState();
    setContent();
  }

  Delta? delta;
  setContent() {
    if (_screenArgs.noteDataEntity.note.isNotEmpty) {
      delta = Delta.fromJson(jsonDecode(_screenArgs.noteDataEntity.note));
      _controller.document = Document.fromDelta(delta!);
      setState(() {});
    }
  }

  bool isKeyboardOpen = false;

  @override
  void dispose() {
    _controller.dispose();
    _editorFocusNode.dispose();
    _editorScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0.0;
    return CustomScaffold(
      title: "",
      actionChild: IconButton(
          onPressed: () => onUpdateNotes(NoteDataEntity(
                id: _screenArgs.noteDataEntity.id,
                bookId: _screenArgs.noteDataEntity.bookId,
                emisUserId: _screenArgs.noteDataEntity.emisUserId,
                note: "Hello Hello",
              )),
          icon: Icon(Icons.check,
              size: size.r24, color: clr.appPrimaryColorGreen)),
      child: QuillProvider(
        configurations: QuillConfigurations(
          controller: _controller,
          sharedConfigurations: QuillSharedConfigurations(
            animationConfigurations: QuillAnimationConfigurations.disableAll(),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w16),
                    child: QuillEditor(
                      scrollController: _editorScrollController,
                      focusNode: _editorFocusNode,
                      configurations: QuillEditorConfigurations(
                        readOnly: _isReadOnly,
                        customStyles: DefaultStyles(
                          code: DefaultTextBlockStyle(
                            TextStyle(
                                fontSize: size.textSmall,
                                color: clr.textColorAppleBlack,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            const VerticalSpacing(16, 0),
                            const VerticalSpacing(0, 0),
                            null,
                          ),
                          placeHolder: DefaultTextBlockStyle(
                            TextStyle(
                                fontSize: size.textXXSmall,
                                color: clr.placeHolderTextColorGray,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            const VerticalSpacing(16, 0),
                            const VerticalSpacing(0, 0),
                            null,
                          ),
                        ),
                        scrollable: true,
                        placeholder: label(e: "Write here", b: "এখানে লিখুন"),
                        padding: EdgeInsets.only(top: size.h12),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (isKeyboardOpen)
              Padding(
                padding: EdgeInsets.all(size.r8),
                child: QuillBaseToolbar(
                  configurations: QuillBaseToolbarConfigurations(
                    toolbarSize: 20 * 2,
                    multiRowsDisplay: false,
                    color: Colors.white,
                    buttonOptions: const QuillToolbarButtonOptions(
                      base: QuillToolbarBaseButtonOptions(
                        iconTheme: QuillIconTheme(
                            iconSelectedColor: Colors.white,
                            iconUnselectedFillColor: Colors.transparent),
                        globalIconSize: 30,
                      ),
                    ),
                    childrenBuilder: (context) {
                      final controller = context.requireQuillController;
                      return [
                        QuillToolbarToggleStyleButton(
                          attribute: Attribute.bold,
                          controller: controller,
                          options: QuillToolbarToggleStyleButtonOptions(
                            iconTheme: QuillIconTheme(
                                iconSelectedColor: clr.appPrimaryColorGreen,
                                iconUnselectedFillColor: Colors.transparent),
                            childBuilder: (options, extraOptions) {
                              final buttonBackgroundColor = extraOptions
                                      .isToggled
                                  ? clr
                                      .appPrimaryColorGreen // Background color when toggled
                                  : Colors.transparent;
                              if (extraOptions.isToggled) {
                                return Container(
                                  color: buttonBackgroundColor,
                                  child: IconButton(
                                    onPressed: extraOptions.onPressed,
                                    icon: Icon(
                                      options.iconData,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                              return IconButton(
                                onPressed: extraOptions.onPressed,
                                icon: Icon(
                                  options.iconData,
                                ),
                              );
                            },
                          ),
                        ),
                        QuillToolbarToggleStyleButton(
                          attribute: Attribute.italic,
                          controller: controller,
                          options: QuillToolbarToggleStyleButtonOptions(
                            childBuilder: (options, extraOptions) {
                              final buttonBackgroundColor = extraOptions
                                      .isToggled
                                  ? clr
                                      .appPrimaryColorGreen // Background color when toggled
                                  : Colors.transparent;
                              if (extraOptions.isToggled) {
                                return Container(
                                  color: buttonBackgroundColor,
                                  child: IconButton(
                                    onPressed: extraOptions.onPressed,
                                    icon: Icon(
                                      options.iconData,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                              return IconButton(
                                onPressed: extraOptions.onPressed,
                                icon: Icon(options.iconData),
                              );
                            },
                          ),
                        ),
                        QuillToolbarToggleStyleButton(
                          attribute: Attribute.underline,
                          controller: controller,
                          options: QuillToolbarToggleStyleButtonOptions(
                            childBuilder: (options, extraOptions) {
                              final buttonBackgroundColor = extraOptions
                                      .isToggled
                                  ? clr
                                      .appPrimaryColorGreen // Background color when toggled
                                  : Colors.transparent;
                              if (extraOptions.isToggled) {
                                return Container(
                                  color: buttonBackgroundColor,
                                  child: IconButton(
                                    onPressed: extraOptions.onPressed,
                                    icon: Icon(
                                      options.iconData,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                              return IconButton(
                                onPressed: extraOptions.onPressed,
                                icon: Icon(options.iconData),
                              );
                            },
                          ),
                        ),
                        QuillToolbarColorButton(
                          controller: controller,
                          isBackground: false,
                          options: const QuillToolbarColorButtonOptions(
                            iconData: Icons.text_format,
                            dialogBarrierColor: Colors.white,
                          ),
                        ),
                        QuillToolbarSelectAlignmentButton(
                          showLeftAlignment: true,
                          showRightAlignment: true,
                          showJustifyAlignment: true,
                          showCenterAlignment: true,
                          controller: controller,
                          options:
                              const QuillToolbarSelectAlignmentButtonOptions(
                            iconButtonFactor: 2,
                            iconSize: 20,
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
