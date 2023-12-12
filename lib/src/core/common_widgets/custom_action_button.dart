import 'package:flutter/material.dart';

import '../constants/common_imports.dart';
import '../network/server_response.dart';

class CustomActionButton<T> extends StatefulWidget {
  final String title;
  // final Future<ActionResult<T>> Function() tapAction;
  final void Function() tapAction;
  final bool Function()? onCheck;
  final void Function(T data) onSuccess;
  final CustomActionButtonController? controller;
  final bool enabled;

  const CustomActionButton({
    Key? key,
    required this.title,
    // required this.tapAction,
    required this.onSuccess,
    this.onCheck,
    this.controller,
    this.enabled = true,
    required this.tapAction,
  }) : super(key: key);

  @override
  State<CustomActionButton<T>> createState() => _CustomActionButtonState<T>();
}

class _CustomActionButtonState<T> extends State<CustomActionButton<T>>
    with AppTheme {
  late Color _buttonTextColor;
  late bool _expanded;
  late int _stateIndex;

  @override
  void initState() {
    _expanded = true;
    _stateIndex = 0;
    _buttonTextColor = Colors.white;
    super.initState();
    // if (widget.controller != null) {
    //   widget.controller?._setAutoTapEventHandler(_onTap);
    // }
    // if (widget.controller != null) {
    //   widget.controller?._setForceTapEventHandler(_executeRequest);
    // }
    if (widget.controller != null) {
      widget.controller?._setSuccessEventHandler(_onSuccess);
    }
    if (widget.controller != null) {
      widget.controller?._setErrorEventHandler(_onError);
    }
  }

  void _onTap() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (mounted && _stateIndex == 0 && widget.enabled) {
      if (widget.onCheck == null || widget.onCheck!()) {
        widget.tapAction.call();
        _executeRequest();
      }
    }
  }

  void _executeRequest() {
    if (mounted) {
      setState(() {
        _expanded = false;
        _stateIndex = 1;
      });
    }

    _lockUi();
    // widget.tapAction().then((x) {
    //   // set state to success
    //   if(mounted) {
    //     setState(() {
    //       try{
    //         if(x.status == Status.success) {
    //           _stateIndex = 2;
    //           Future.delayed(const Duration(milliseconds: 700)).whenComplete((){
    //             if(mounted) widget.onSuccess.call(x.data as T);
    //           });
    //         }else{
    //           _stateIndex = 3;
    //         }
    //       }catch(e){
    //         _stateIndex = 3;
    //       }
    //     });
    //   }
    // }).catchError((x) {
    //   // set state to error
    //   if(mounted) {
    //     setState(() {
    //       _stateIndex = 3;
    //     });
    //   }
    // }).whenComplete(() {
    //   // reset state to normal
    //   _unlockUi();
    //   Future.delayed(const Duration(milliseconds: 1200)).then((x) {
    //     if(mounted) {
    //       setState(() {
    //         _expanded = true;
    //         _stateIndex = 0;
    //       });
    //     }
    //   });
    // });
  }

  void _onSuccess() {
    _unlockUi();
    if (mounted) {
      setState(() {
        _stateIndex = 2;
      });
    }
  }

  void _onError() {
    _unlockUi();
    if (mounted) {
      setState(() {
        _stateIndex = 3;
      });
    }
    Future.delayed(const Duration(milliseconds: 600)).then((x) {
      if (mounted) {
        setState(() {
          _expanded = true;
          _stateIndex = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          height: size.h40,
          width: _expanded ? MediaQuery.of(context).size.width : size.w44,
          padding: EdgeInsets.all(size.w4),
          decoration: BoxDecoration(
            color: clr.appPrimaryColorGreen,
            borderRadius: BorderRadius.circular(_expanded ? size.w28 : 100),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Fader(
              index: _stateIndex,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: size.textXMedium,
                    color: clr.shadeWhiteColor,
                    fontFamily: StringData.fontFamilyRoboto,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.h24,
                  width: size.w24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(_buttonTextColor),
                    strokeWidth: size.w2,
                  ),
                ),
                Icon(Icons.check, color: _buttonTextColor, size: size.r24),
                Icon(Icons.close, color: _buttonTextColor, size: size.r24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isUiLocked = false;
  void _lockUi() async {
    if (!_isUiLocked) {
      _isUiLocked = true;
      await showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(.07),
          builder: (x) {
            return Material(
              type: MaterialType.transparency,
              child: WillPopScope(
                onWillPop: () async => false,
                child: Container(),
              ),
            );
          });
      _isUiLocked = false;
    }
  }

  void _unlockUi() {
    if (_isUiLocked) {
      Navigator.of(context).pop();
    }
  }
}

class CustomActionButtonController {
  // VoidCallback? _autoTapEvent;
  // VoidCallback? _forceTapEvent;
  VoidCallback? _successTapEvent;
  VoidCallback? _errorTapEvent;
  // void _setAutoTapEventHandler(VoidCallback event) {
  //   _autoTapEvent = event;
  // }
  //
  // void _setForceTapEventHandler(VoidCallback event) {
  //   _forceTapEvent = event;
  // }

  void _setSuccessEventHandler(VoidCallback event) {
    _successTapEvent = event;
  }

  void _setErrorEventHandler(VoidCallback event) {
    _errorTapEvent = event;
  }

  // void tap() {
  //   if (_autoTapEvent != null) {
  //     _autoTapEvent!();
  //   }
  // }
  //
  // void forceTap() {
  //   _forceTapEvent?.call();
  // }

  void successTap() {
    _successTapEvent?.call();
  }

  void errorTap() {
    _errorTapEvent?.call();
  }
}

class Fader extends StatefulWidget {
  final int index;
  final List<Widget> children;

  const Fader({Key? key, required this.index, required this.children})
      : super(key: key);

  @override
  State<Fader> createState() => _FaderState();
}

class _FaderState extends State<Fader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Widget _widget;

  @override
  void initState() {
    _widget = widget.children.elementAt(widget.index);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCubic));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Fader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _animationController.forward().then((x) {
        _widget = widget.children.elementAt(widget.index);
      }).then((x) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: _widget,
        );
      },
    );
  }
}

class ActionResult<T> {
  late Status status;
  late String message;
  late T? data;
  ActionResult({required this.status, required this.message, this.data});

  ActionResult.fromServerResponse(
      {required ServerResponse response,
      required T Function(dynamic data) generateData}) {
    // status = _StatusExtensionMap.state(response.status);
    message = response.message;
    data = status == Status.success ? generateData(response.data) : null;
  }

  ActionResult.error({String msg = "Request failed! Unknown error occurred."}) {
    status = Status.error;
    message = msg;
  }
}

enum Status {
  success,
  warning,
  error,
  empty,
}

extension _StatusExtensionMap on Status {
  static const _valueMap = {
    Status.error: 0,
    Status.success: 1,
    Status.warning: 2,
    Status.empty: 3,
  };

  int get value => _valueMap[this] ?? 0;
  static Status state(int value) =>
      _valueMap.keys.firstWhere((element) => element.value == value,
          orElse: () => Status.error);
}
