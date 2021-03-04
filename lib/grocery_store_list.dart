import 'package:flutter/material.dart';
import 'package:platanos/grocery_provider.dart';
import 'package:platanos/main.dart';

class GroceryStoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context).bloc;
    return StaggeredDualView()
    /*
    return ListView.builder(
      padding: EdgeInsets.only(top: cartBarHeight),
      itemCount: bloc.catalog.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          width: 100,
          color: Colors.primaries[index % Colors.primaries.length],
        );
      },
    );
    */
  }
}
