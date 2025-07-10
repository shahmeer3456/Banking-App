import 'package:bank/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).clearCart();
            },
          )
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.cartMap.length,
                  itemBuilder: (context, index) {
                    var item = provider.cartMap.values.toList()[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('Rs. ${item.price} x ${item.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              provider.removeItem(item);
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              provider.addItem(item);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Text(
                'Total Price: Rs. ${provider.getTotalPrice()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );

  }
}