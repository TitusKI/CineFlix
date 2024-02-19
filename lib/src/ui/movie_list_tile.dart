import 'package:flutter/material.dart';
import '../blocs/movies_bloc.dart';
import 'movie_list.dart';

class MovieListTile extends StatefulWidget {
  final Widget? child;
  final String? txt1;
  final String? txt2;
  final String? txt3;
  final String? txt4;
  final int index;
  MovieListTile(
      {this.child,
      this.txt1,
      this.txt2,
      this.txt3,
      this.txt4,
      required this.index});

  @override
  _MovieListTileState createState() {
    return _MovieListTileState(popupContent: []);
  }
}

class _MovieListTileState extends State<MovieListTile> {
  GlobalKey _rowkey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late List<Widget> _popupContent = [];
  _MovieListTileState({required List<Widget> popupContent}) {
    // List<String?> popupContent = [widget.txt1, widget.txt2, widget.txt3, widget.txt4];
    // // ignore: unnecessary_null_comparison
    _popupContent = popupContent
        .where((item) => item is String && (item as String).isNotEmpty)
        .map((item) => _buildPopupItem(item as String))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _popupContent = [
      _buildPopupItem(widget.txt1 ?? ''),
      _buildPopupItem(widget.txt2 ?? ''),
      _buildPopupItem(widget.txt3 ?? ''),
      _buildPopupItem(widget.txt4 ?? ''),
    ];
    bloc.selectedTileIndexStream.listen((index) {
      if (index == widget.index) {
        _showPopup();
      } else {
        hidePopup();
      }
    });

  
    bloc.hidePopupStream.listen((event) {
      if (event) {
        hidePopup();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      child: InkWell(
        key: _rowkey,
        onTap: () {
          bloc.handleTileTap(widget.index, [
            widget.txt1 ?? '',
            widget.txt2 ?? '',
            widget.txt3 ?? '',
            widget.txt4 ?? ''
          ]);
        },
        child: widget.child!,
      ),
    );
  }

  void _showPopup() {
    if (_rowkey.currentContext != null) {
      _overlayEntry = OverlayEntry(
        builder: (context) {
          RenderBox renderBox =
              _rowkey.currentContext!.findRenderObject() as RenderBox;
          Offset position =
              renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
          // Calculate the total height of all ListTiles

          return Positioned(
              left: position.dx,
              top: position.dy,
              width: 120,
              height: 130 + _popupContent.length * 30,
              // Adjust the height based on the number of items
              child: Stack(
                children: [
                  Material(
                    child: ClipRRect(
                      child: Container(
                        color: Colors.white60,
                        child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: _popupContent),
                      ),
                    ),
                  ),
                ],
              ));
        },
      );

      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void hidePopup() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  Widget _buildPopupItem(String? item) {
    if (item != null && item.isNotEmpty) {
      return ListTile(
        title: Text(
          item,
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          print('clicked');
        },
      );
    } else {
      return Container(); // Return an empty container if item is null or empty
    }
  }
}
