import 'package:flutter/material.dart';
import 'package:platanos/grocery_provider.dart';
import 'package:platanos/grocery_store_details.dart';
import 'package:platanos/main.dart';
import 'package:platanos/meal.dart';

class GroceryStoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider
        .of(context)
        .bloc;
    return Container(
      color: backgrounColor,
      padding: EdgeInsets.only(top: cartBarHeight, left: 10, right: 10),
      child: StaggeredDualView(
        aspectRatio: 0.65,
        offsetPercent: 0.3,
        spacing: 20,
        itemBuilder: (context, index) {
          final product = bloc.catalog[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, __) {
                        return FadeTransition(
                            opacity: animation,
                            child: GroceryStoreDetails(
                              product: product
                            )
                        );
                      }
                  )
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              elevation: 8,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'list_${product.name}',
                        child: Image.asset(
                            product.image,
                            fit: BoxFit.contain
                        ),
                      ),
                    ),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      product.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14
                      ),
                    ),
                    Text(
                      product.weight,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 14
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: meals.length,
      ),
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 8,
      shadowColor: Colors.black54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipOval(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(meal.image, fit: BoxFit.cover))),
          ),
          SizedBox(height: 10),
          Expanded(
              child: Column(
                children: [
                  Text(
                    meal.name,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    meal.weight,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        5,
                            (index) =>
                            Icon(
                              index < 4 ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                            )),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView({Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.spacing = 0.0,
    this.aspectRatio = 0.5,
    this.offsetPercent = 0.5})
      : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;
  final double offsetPercent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspectRatio;
      final heigth = constraints.maxHeight + itemHeight;
      return OverflowBox(
        maxWidth: width,
        minWidth: width,
        minHeight: heigth,
        maxHeight: heigth,
        child: GridView.builder(
          padding: EdgeInsets.only(top: itemHeight / 2, bottom: itemHeight),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Transform.translate(
                offset: Offset(
                    0.0, index.isOdd ? itemHeight * offsetPercent : 0.0),
                child: itemBuilder(context, index));
          },
        ),
      );
    });
  }
}
