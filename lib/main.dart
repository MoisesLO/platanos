import 'package:flutter/material.dart';
import 'package:platanos/grocery_provider.dart';
import 'package:platanos/grocery_store_bloc.dart';
import 'package:platanos/grocery_store_list.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Platanos',
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: HomePage(),
    );
  }
}

const backgrounColor = Color(0XFFF6F5F2);
const cartBarHeight = 100.0;
const _panelTransition = Duration(milliseconds: 500);


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = GroceryStoreBloC();

  void _onVerticalGesture(DragUpdateDetails details){
    if(details.primaryDelta < -7) {
      bloc.changeToCard();
    }else if (details.primaryDelta > 12) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(GroceryState state, Size size){
    if (state == GroceryState.normal) {
      return -cartBarHeight;
    }else if (state == GroceryState.cart){
      return - (size.height - kToolbarHeight - cartBarHeight / 2);
    }
    return 0.0;
  }

  double _getTopForBlackPanel(GroceryState state, Size size){
    if (state == GroceryState.normal) {
      return size.height - kToolbarHeight - cartBarHeight;
    }else if (state == GroceryState.cart){
      return cartBarHeight / 2;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GroceryProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                _AppBarGrocery(),
                Expanded(
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: _panelTransition,
                          curve: Curves.decelerate,
                          left: 0,
                          right: 0,
                          top: _getTopForWhitePanel(bloc.groceryState, size),
                          height: size.height - kToolbarHeight,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)
                              ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: GroceryStoreList(),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: _panelTransition,
                          curve: Curves.decelerate,
                          left: 0,
                          right: 0,
                          top: _getTopForBlackPanel(bloc.groceryState, size),
                          height: size.height,
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          );
        }
      ),
    );
  }
}


class _AppBarGrocery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: backgrounColor,
      child: Row(
        children: [
          BackButton(color: Colors.black),
          SizedBox(width: 10),
          Expanded(
              child: Text(
            'Fruit and vetegables',
            style: TextStyle(color: Colors.black),
          )),
          IconButton(icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
