import 'package:bank/provider/hotel_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hotel_model.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<HotelProvider>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Booking"),
          trailing: Icon(Icons.shopping_cart),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final bookedRoom = roomProvider.bookedRooms.values
                    .toList()[index];
                return ListTile(
                  title: Text(bookedRoom.name),
                  leading: Text("${bookedRoom.quantity}"),
                );
              },
              itemCount: roomProvider.bookedRooms.length,
            ),
          ),
        ],
      ),
    );
  }
}
