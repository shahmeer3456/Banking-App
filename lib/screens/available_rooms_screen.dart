import 'package:bank/screens/booking_screen.dart';
import 'package:bank/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hotel_model.dart';
import '../provider/hotel_provider.dart';

class AvailableRooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<HotelProvider>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Available rooms"),
          trailing: Icon(Icons.hotel),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: roomProvider.availableRooms.length,
              itemBuilder: (context, index) {
                final room = roomProvider.availableRooms[index];
                return ListTile(
                  title: Text(room.name),
                  leading: Icon(Icons.bedroom_child),
                  subtitle: Text(
                    "${room.description}\nRs. ${room.pricePerNight} per night",
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      roomProvider.addRoom(room);
                    },
                    child: Icon(Icons.add),
                  ),
                );
              },
            ),
          ),
          Container(
            width: 367,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  "  Booked rooms ${roomProvider.totalRooms()}",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingScreen()),
                    );
                  },
                  icon: Icon(Icons.shopping_cart_checkout_outlined),
                  color: Colors.white,
                  iconSize: 45,
                ),
              ],
            ),
          ),
          SizedBox(height: 28),
        ],
      ),
    );
  }
}
