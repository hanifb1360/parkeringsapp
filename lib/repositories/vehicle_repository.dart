import '../models/vehicle.dart';

class VehicleRepository {
  final List<Vehicle> _vehicles = [];

  void add(Vehicle vehicle) {
    _vehicles.add(vehicle);
  }

  List<Vehicle> getAll() {
    return _vehicles;
  }

  Vehicle getByRegistrationNumber(String registrationNumber) {
    return _vehicles.firstWhere(
      (v) => v.registrationNumber == registrationNumber,
      orElse: () => throw Exception('Vehicle not found'),
    );
  }

  void update(Vehicle vehicle) {
    var index = _vehicles
        .indexWhere((v) => v.registrationNumber == vehicle.registrationNumber);
    if (index != -1) {
      _vehicles[index] = vehicle;
    }
  }

  void delete(String registrationNumber) {
    _vehicles.removeWhere((v) => v.registrationNumber == registrationNumber);
  }
}
