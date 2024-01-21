import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

///Paginated List View
class PaginatedGridView<T> extends StatefulWidget {
  final PaginatedGridViewController<T> controller;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context) loaderBuilder;
  final SliverGridDelegate gridDelegate;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;

  const PaginatedGridView({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    required this.loaderBuilder,
    this.physics, this.padding, this.shrinkWrap=false, required this.gridDelegate,
  }) : super(key: key);

  @override
  _PaginatedGridViewState<T> createState() => _PaginatedGridViewState<T>();
}
class _PaginatedGridViewState<T> extends State<PaginatedGridView<T>> with AppTheme{
  @override
  void initState() {
    super.initState();
    widget.controller._updateStateDelegate = onUpdateState;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(!widget.shrinkWrap)Expanded(
          child: GridView.builder(
            gridDelegate: widget.gridDelegate,
            controller: widget.controller._scrollController,
            itemCount: widget.controller._items.length,
            physics: widget.physics,
            padding: widget.padding,
            shrinkWrap: false,
            itemBuilder: (context, index){
              return widget.itemBuilder(context,widget.controller._items[index], index);
            },
          ),
        ) else GridView.builder(
          gridDelegate: widget.gridDelegate,
          controller: widget.controller._scrollController,
          itemCount: widget.controller._items.length,
          physics: widget.physics,
          padding: widget.padding,
          shrinkWrap: true,
          itemBuilder: (context, index){
            return widget.itemBuilder(context,widget.controller._items[index], index);
          },
        ),
        if(widget.controller._isLoading)
          Container(
            constraints: const BoxConstraints(maxHeight: 32),
            child: widget.loaderBuilder(context),
          ),
      ],
    );
  }

  void onUpdateState() {
    if(mounted) {
      setState(() {
        debugPrint("state_updated");
      });
    }
  }
}
class PaginatedGridViewController<T>{
  late List<T> _items;
  late int _pageSize;
  late int _totalItemCount;
  late int _currentPage;
  late int _nextPage;
  late double _loadTriggerOffset;
  late ScrollController _scrollController;

  bool _isLoading = false;
  VoidCallback? _updateStateDelegate;
  Future<bool> Function(int nextPage)? _loadMoreDelegate;

  PaginatedGridViewController([int pageSize = 10, double loadTriggerOffset = 150]) {
    _pageSize = pageSize;
    _loadTriggerOffset = loadTriggerOffset;
    _totalItemCount = 0;
    _currentPage = 0;
    _nextPage = 1;
    _items = [];

    _scrollController = ScrollController();
    _scrollController.addListener(_onScrollUpdate);
  }

  void dispose(){
    _scrollController.removeListener(_onScrollUpdate);
    _scrollController.dispose();
  }

  ///Getters
  int get pageSize => _pageSize;
  int get currentPage => _currentPage;
  int get nextPage => _nextPage;
  int get totalItemCount => _totalItemCount;

  ///Setters
  void setTotalItemCount(int count){
    if(count > -1){
      _totalItemCount = count;
    }
  }
  set onLoadMore(Future<bool> Function(int nextPage) function){
    _loadMoreDelegate = function;
  }

  void clear(){
    _items.clear();
    _currentPage = 0;
    _nextPage = 1;
    _updateStateDelegate?.call();
  }
  void addItem(T item){
    _items.add(item);
    _updateStateDelegate?.call();
  }
  void addItems(List<T> items){
    _items.addAll(items);
    _updateStateDelegate?.call();
  }
  void _onScrollUpdate() {
    if(
    !_isLoading
        && _totalItemCount > _items.length
        && _scrollController.position.maxScrollExtent > _loadTriggerOffset
        && _scrollController.position.extentAfter <= _loadTriggerOffset
    ){
      if(_loadMoreDelegate != null){
        _isLoading = true;
        _updateStateDelegate?.call();

        _loadMoreDelegate!(_nextPage).then((value){
          if(value){
            _currentPage = _nextPage;
            _nextPage += 1;
          }
        }).whenComplete((){
          _isLoading = false;
          _updateStateDelegate?.call();
        });
      }
    }
  }
}