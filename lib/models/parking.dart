import 'vehicle.dart';
import 'parking_space.dart';

class Parking {
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime startTime;
  DateTime? endTime;

  Parking({
    required this.vehicle,
    required this.parkingSpace,
    required this.startTime,
    this.endTime,
  });

  @override
  String toString() {
    String status = endTime == null ? "ongoing" : "ended";
    return 'Parking(vehicle: ${vehicle.registrationNumber}, parkingSpace: ${parkingSpace.id}, status: $status)';
  }
}
