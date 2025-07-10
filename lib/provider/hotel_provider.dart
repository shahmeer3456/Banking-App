import 'package:flutter/cupertino.dart';

import '../models/hotel_model.dart';

class HotelProvider with ChangeNotifier {
  Map<int, Room> bookedRooms = {};
  List<Room> availableRooms = [
    Room(
      id: 1,
      name: "Deluxe Room",
      pricePerNight: 5000,
      description: "Sea View",
    ),
    Room(
      id: 2,
      name: "Standard Room",
      pricePerNight: 3000,
      description: "City View",
    ),
    Room(
      id: 3,
      name: "Executive Suite",
      pricePerNight: 8000,
      description: "Luxury Stay",
    ),
  ];

  void addRoom(Room room) {
    if (bookedRooms.containsKey(room.id)) {
      bookedRooms[room.id]!.quantity++;
    } else {
      bookedRooms[room.id] = Room(
        id: room.id,
        name: room.name,
        description: room.description,
        pricePerNight: room.pricePerNight,
        quantity: 1,
        nights: 1,
      );
    }
    notifyListeners();
  }

  void removeRoom(Room room) {
    if (bookedRooms.containsKey(room.id)) {
      if (bookedRooms[room.id]!.quantity > 1) {
        bookedRooms[room.id]!.quantity--;
      } else {
        bookedRooms.remove(room.id);
      }
    }
    notifyListeners();
  }

  void clearBooking() {
    bookedRooms.clear();
    notifyListeners();
  }

  double totalBill() {
    double totalBill = 0;
    bookedRooms.forEach((key, room) {
      totalBill += room.pricePerNight * room.quantity * room.nights;
    });
    return totalBill;
  }

  int totalRooms() {
    int totalRooms = 0;
    bookedRooms.forEach((key, room) {
      totalRooms += room.quantity;
    });
    return totalRooms;
  }
}
