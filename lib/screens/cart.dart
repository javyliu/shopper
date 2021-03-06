import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopper/models/cart.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log("-- my cart build");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: _CartList(),
              ),
            ),
            Divider(
              height: 4,
              color: Colors.blue,
            ),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log("-- cartlist build");

    var itemNameStyle = Theme.of(context).textTheme.headline6;
    var cart = context.watch<CartModel>();

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            cart.remove(cart.items[index]);
          },
        ),
        title: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log("-- cart total build");

    var hugeStyle = Theme.of(context).textTheme.headline1.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
              builder: (context, value, child) => Text(
                '\$${value.totalPrice}',
                style: hugeStyle,
              ),
            ),
            SizedBox(
              width: 24,
            ),
            FlatButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Buying not supported yet.")));
              },
              child: Text("BUY"),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
