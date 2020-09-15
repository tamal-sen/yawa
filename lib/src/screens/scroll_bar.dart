import 'package:flutter/material.dart';


class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
          child: Stack(
            children: [
//              Container(
//                height: 400,
//                child: Text('boo'),
//              ),
              Container(
                height: MediaQuery.of(context).size.height,
        child: DraggableScrollableSheet(
              initialChildSize: .5,
//              expand: true,
              minChildSize: .3,
              maxChildSize: 1.0,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
//                  color: Colors.blue[100],
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    },
                  ),
                );
              },
        ),
      ),
            ],
          ),
    );
  }
}
