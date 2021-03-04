import 'package:flutter/material.dart';
import 'package:platanos/grocery_product.dart';

enum GroceryState {
  normal,
  details,
  cart
}

class GroceryStoreBloC with ChangeNotifier {

  GroceryState groceryState = GroceryState.normal;
  List<GroceryProduct> catalog = List.unmodifiable(groceryProducts);

  void changeToNormal(){
    groceryState = GroceryState.normal;
    notifyListeners();
  }

  void changeToCard() {
    groceryState = GroceryState.cart;
    notifyListeners();
  }
}