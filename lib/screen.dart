import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollableTable extends StatefulWidget {
  const ScrollableTable({
    Key? key,
  }) : super(key: key);

  @override
  _ScrollableTableState createState() => _ScrollableTableState();
}

class _ScrollableTableState extends State<ScrollableTable> {
  ScrollController _leftScrollController = ScrollController();
  ScrollController _rightScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _leftScrollController.addListener(_syncScroll);
    _rightScrollController.addListener(_syncScroll);

  }

  void _syncScroll() {
    // Synchronize scroll positions of left and right sections


    if (_rightScrollController.position.userScrollDirection == ScrollDirection.forward ||
        _rightScrollController.position.userScrollDirection == ScrollDirection.reverse) {
      double offset2 = _rightScrollController.offset;
      _leftScrollController.jumpTo(offset2);
    }else{
      double offset1 = _leftScrollController.offset;

      _rightScrollController.jumpTo(offset1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scroll Functionality"),),
      backgroundColor: Colors.black,
      body: Center(
          child: Row(
        children: [
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.horizontal,reverse: true,
controller: _leftScrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                mainAxisSpacing: 1.5,
                crossAxisSpacing: 1.5,
              ),
              itemBuilder: (_, index) => Container(
                color: Colors.white,
                child: Text("0"),
              ),
              itemCount: 250,
            ),
          ),
          Container(
              color: Colors.grey,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [Text("strike "), Text(" IV")],
                  )
                ],
              )),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              controller: _rightScrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                mainAxisSpacing: 1.5,
                crossAxisSpacing: 1.5,
              ),
              itemBuilder: (_, index) => Container(
                color: Colors.white,
                child: Text("1"),
              ),
              itemCount: 250,
            ),
          )
        ],
      )),
    );
  }
}

class TableData {
  final List<String> columns;
  final List<List<dynamic>> rows;

  TableData({required this.columns, required this.rows});
}
