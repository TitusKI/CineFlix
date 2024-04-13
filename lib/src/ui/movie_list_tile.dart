import 'package:cineflix/src/ui/item_navigation.dart';
import 'package:flutter/material.dart';
import '../blocs/movies_bloc.dart';

class MovieListTile extends StatefulWidget {
  final Widget? child;
  final String? txt1;
  final String? txt2;
  final String? txt3;
  final String? txt4;
  final int index;

  const MovieListTile(
      {super.key,
      this.child,
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
  final GlobalKey _rowkey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late List<Widget> _popupContent = [];
  int startingIndex = 1;
  _MovieListTileState({required List<Widget> popupContent}) {
    // List<String?> popupContent = [widget.txt1, widget.txt2, widget.txt3, widget.txt4];
    // // ignore: unnecessary_null_comparison
    _popupContent = popupContent
        .asMap()
        .entries
        // .where((item) => item is String && (item as String).isNotEmpty)
        .map((item) =>
            _buildPopupItem(item.value as String, item.key + startingIndex))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _popupContent = [
      _buildPopupItem(widget.txt1 ?? '', 1),
      _buildPopupItem(widget.txt2 ?? '', 2),
      _buildPopupItem(widget.txt3 ?? '', 3),
      _buildPopupItem(widget.txt4 ?? '', 4),
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
    return SizedBox(
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
                        color: Colors.black,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: _popupContent,
                        ),
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

  Widget _buildPopupItem(String? item, int itemIndex) {
    if (item != null && item.isNotEmpty) {
      return ListTile(
          title: Text(
            item,
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            bloc.handleHidePopup();
            Future.delayed(const Duration(milliseconds: 200), () {
              //   if(widget.index == 3){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> PeopleScreen(buttonIndex: widget.index,itemIndex: itemIndex,)));
              //   }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemNavigation(
                            buttonIndex: widget.index,
                            itemIndex: itemIndex,
                            pageTitle: "",
                          )));
            });
          });
    } else {
      return Container();
    }
  }
}
