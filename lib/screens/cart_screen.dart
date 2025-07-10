import 'package:bank/provider/cart_provider.dart';
import 'package:bank/screens/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<CartProvider>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: itemProvider.availableProductsMap.length,
                itemBuilder: (context, index) {
                  var item = itemProvider.availableProductsMap.values
                      .toList()[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text("\$ ${item.price}"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        itemProvider.addItem(item);
                      },
                      child: Text("Add to cart"),
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Items Selected: ${itemProvider.getTotalItems()}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 34),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckOutScreen()),
                    );
                  },
                  child: Icon(Icons.shopping_cart_checkout, size: 40),
                ),
              ],
            ),
            SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}
