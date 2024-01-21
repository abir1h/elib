import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/app_theme.dart';

class Toasty{
  OverlayState? _overlayState;
  static OverlayEntry? _uiLockOverlayEntry;
  static bool _isUiLocked = false;
  late BuildContext _context;

  // constructor
  Toasty.of(BuildContext context){
    try {
      _context = context;
      _overlayState = Overlay.of(context);
      _uiLockOverlayEntry ??= OverlayEntry(builder: _buildUiLockOverlayEntry);
    }catch(_){}
  }


  // public methods
  showSuccess(String message, {Duration duration = const Duration(milliseconds: 3000)}){
    _showToast(message,duration,"success");
  }
  showWarning(String message, {Duration duration = const Duration(milliseconds: 3000)}){
    _showToast(message,duration,"warning");
  }
  showError({String message="Couldn't connect to the server.", Duration duration = const Duration(milliseconds: 3000)}){
    _showToast(message,duration,"error");
  }
  _showToast(String message, Duration duration, String type){
    ToastOverlayEntry overlay = ToastOverlayEntry(
      message: message,
      duration: duration,
      type: type,
    );
    _overlayState?.insert(overlay.overlayEntry);
  }



  // block touch screens
  lockUI({bool blockBackPress=false}){
    if(!_isUiLocked) {
      showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (context){
            return WillPopScope(
              onWillPop: ()async{return Future.value(!blockBackPress);},
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      top: 24.w,
                      bottom: 24.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.w),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 42.w,
                          width: 42.w,
                          child: CircularProgressIndicator(
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.indigo,
                            ),
                            strokeWidth: 2.w,
                          ),
                        ),
                        SizedBox(height: 16.w,),
                        Text(
                          "Please wait..",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 20.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ).whenComplete((){
        _isUiLocked = false;
      });
      _isUiLocked = true;
    }
  }
  Future releaseUI()async{
    if(_isUiLocked) {
      return Navigator.of(_context).pop();
    }else{
      return;
    }
  }
  Widget _buildUiLockOverlayEntry(BuildContext context) {
    var screen = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: ()=> Future<bool>.value(false),
      child: Container(
        color: Colors.transparent,
        height: screen.size.height,
        width: screen.size.width,
      ),
    );
  }


}

class ToastOverlayEntry{
  late final String message;
  late final Duration duration;
  late final String type;

  // constructor
  ToastOverlayEntry({
    required this.message,
    required this.duration,
    required this.type,
  });


  // overlay entry getter
  OverlayEntry? _overlayEntry;
  OverlayEntry get overlayEntry {
    _overlayEntry = OverlayEntry(
        builder: (x)=> _Toast(
          context: x,
          message: message,
          duration: duration,
          type: type,
          onRemove:_onRemove,
        )
    );
    return _overlayEntry!;
  }

  void _onRemove() {
    if(_overlayEntry != null)
    {
      try{
        _overlayEntry?.remove();
      }
      catch (e)
      {
        debugPrint(e.toString());
      }
    }
  }
}
class _Toast extends StatefulWidget {
  final BuildContext context;
  final String message;
  final Duration duration;
  final String type;
  final VoidCallback onRemove;

  const _Toast({Key? key,
    required this.context,
    required this.message,
    required this.duration,
    required this.type,
    required this.onRemove,
  }) : super(key: key);

  @override
  __ToastState createState() => __ToastState();
}
class __ToastState extends State<_Toast> with SingleTickerProviderStateMixin,AppTheme{
  late AnimationController _animationController;
  late Animation<double> _offsetAnimation;

  Color _color =  const Color(0xFFFFE03C);
  late IconData _icon;
  @override
  void initState() {
    super.initState();

    // animation initialization
    _animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 300));
    _offsetAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInCubic));


    // color and icon initialization;
    if(widget.type == "success")
    {
      _color = const Color(0xFF0CE505);
      _icon = CupertinoIcons.check_mark_circled_solid;
    }
    else if(widget.type == "warning")
    {
      _color = Colors.amber;
      _icon = Icons.error;
    }
    else {
      _color = Colors.redAccent;
      _icon = Icons.error;
    }


    // start animation
    SchedulerBinding.instance.addPostFrameCallback((x){
      _handleAnimation();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAnimation()
  {
    _animationController.forward().then((x){
      return Future.delayed(widget.duration);
    }).then((x){
      _animationController.reverse().then((x){
        widget.onRemove();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);
    return Positioned(
      left: 0,
      top: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, Widget? child){
          return FractionalTranslation(
            translation: Offset(0, _offsetAnimation.value),
            child: child,
          );
        },
        child: Material(
          child: Container(
            width: screen.size.width,
            padding: EdgeInsets.only(left: size.h16, right: size.h16, bottom: size.h12, top: MediaQuery.of(context).padding.top+ size.h4),
            decoration: BoxDecoration(
              // color: const Color(0x4A000000),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: Offset(0, 3.w),
                  blurRadius: 10.w,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _icon,
                  color: _color,
                  size: size.h28,
                ),
                SizedBox(
                  width: size.h8,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: size.textSmall,
                        color: _color,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
