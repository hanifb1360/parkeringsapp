import 'vehicle.dart';
import 'parking_space.dart';

class Parking {
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime startTime;
  DateTime? endTime; // Can be null if ongoing

  Parking({required this.vehicle, required this.parkingSpace, required this.startTime, this.endTime});

  @override
  String toString() {
    return 'Parking(vehicle: ${vehicle.registrationNumber}, parkingSpace: ${parkingSpace.id}, startTime: $startTime, endTime: $endTime)';
  }
}
