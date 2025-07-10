import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {

  Map<int, CartItem> cartMap = {};

  Map<int, CartItem> availableProductsMap = {
    1: CartItem(id: 1, name: "Wireless Headphones", price: 4500.0, quantity: 1),
    2: CartItem(id: 2, name: "Smart Watch", price: 6000.0, quantity: 2),
    3: CartItem(id: 3, name: "Gaming Mouse", price: 2500.0, quantity: 1),
    4: CartItem(id: 4, name: "Mechanical Keyboard", price: 7000.0, quantity: 1),
    5: CartItem(id: 5, name: "Bluetooth Speaker", price: 3200.0, quantity: 3),
  };


  void addItem(CartItem i) {
    if (cartMap.containsKey(i.id)) {
      cartMap[i.id]!.quantity++;
    } else {
      cartMap[i.id] = CartItem(
        id: i.id,
        name: i.name,
        price: i.price,
        quantity: 1,
      );
    }
    notifyListeners();
  }

  void removeItem(CartItem i) {
    if(cartMap[i.id]!.quantity>1)
      {
        cartMap[i.id]!.quantity--;
      }
    else
      {
        cartMap.remove(i.id);
      }
    notifyListeners();
  }

  void clearCart()
  {
    cartMap.clear();
    notifyListeners();
  }

  double getTotalPrice()
  {
    double total=0;
    cartMap.forEach((key,item){
      total+=item.price*item.quantity;
    });
    return total;
  }

  int getTotalItems()
  {
    int totalItems=0;
    cartMap.forEach((key,item){
      totalItems+=item.quantity;
    });
    return totalItems;
  }


}
