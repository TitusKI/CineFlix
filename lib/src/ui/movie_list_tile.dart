import 'package:flutter/material.dart';
import '../blocs/movies_bloc.dart';
import 'movie_list.dart';

class MovieListTile extends StatefulWidget{
  final Widget? child;
  final String? txt1;
  final String? txt2;
  final String? txt3;
  final String? txt4;
  MovieListTile({ this.child, this.txt1, this.txt2, this.txt3, this.txt4});

@override
_MovieListTileState createState(){
  
 return _MovieListTileState();
}

}
class _MovieListTileState extends State<MovieListTile>{
  GlobalKey _rowkey = GlobalKey();
  OverlayEntry? _overlayEntry; 
  late Widget _storeChild = Container();
  
 
  @override
  void initState(){
    super.initState();
     bloc.showPopupStream.listen((event){
    if(event){
      _showPopup();
    }
  });
  bloc.hidePopupStream.listen((event) {
    if(event){
      hidePopup();
    }
  });
     _storeChild = widget.child!;
  }

  @override
  Widget build(BuildContext context){
   
    return Container(
      height: 30,
      width:100,
      child: InkWell(
       key: _rowkey,
       onTap: ( ){
        
         bloc.handleShowPopup();
       },
       onTapCancel: bloc.handleHidePopup(),
      
       child: _storeChild,
      ),
    );
  }
  void _showPopup(){
    _overlayEntry = OverlayEntry(
      builder: (context) {
        String? text1 = widget.txt1;// wwidget is used to access the variables from the above class
        String? text2 = widget.txt2;
      
        String? text3 = widget.txt3;
        String? text4 = widget.txt4;
        RenderBox renderBox = _rowkey.currentContext!.findRenderObject() as RenderBox;
         // Calculate the position below the main hover click
      Offset position = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
        return Positioned(
          left: position.dx,
          top: position.dy,
           
            width:100,
            height: 150,
            child: Stack(
              children:[ Material(
                child: Container(
                  color: Colors.white60,
                  child: ListView(
                    children: [
                      _buildPopupItem('$text1'),
                      _buildPopupItem('$text2'),
                      _buildPopupItem('$text3'),
                      _buildPopupItem('$text4')
                        
                    ],
                  ),
                ),
              ),
          // to make scrollable in the stack widget
          Positioned.fill(
            child: GestureDetector(
              onTap: hidePopup,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          )
          ],)
          );
        
      },
      );
      Overlay.of(context).insert(_overlayEntry!);// for inserting the overlay to the popup
  }
  void hidePopup(){
    if(_overlayEntry != null){
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
  _buildPopupItem(String item){
    return ListTile(
      title: Text(
        item,
        style: TextStyle(color: Colors.white ),
      ),
      onTap: (){
        print('clicked');
      },
    );

  }
  

  }
