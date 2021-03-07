import 'package:flutter/material.dart';
import 'package:platanos/grocery_product.dart';

class GroceryStoreDetails extends StatelessWidget {
  const GroceryStoreDetails({Key key, @required this.product})
      : super(key: key);
  final GroceryProduct product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'list_${product.name}',
          child: Image.asset(
            product.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
