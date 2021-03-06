import 'package:flutter/material.dart';
import 'package:platanos/grocery_provider.dart';
import 'package:platanos/main.dart';

class GroceryStoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context).bloc;
    return StaggeredDualView(
      itemBuilder: (context, index) {
        return MealItem(
          meal: meals[index]
        );
      },
        itemCount: meals.length,
    );
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

class MealItem extends StatelessWidget {
  const MealItem({Key key, this.meal}) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView(
      {
        Key key,
        @required this.itemBuilder,
        @required this.itemCount,
        this.spacing = 0.0,
        this.aspectRatio = 0.5
      })
      : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing
      ),
      itemBuilder: itemBuilder,
    );
  }
}
