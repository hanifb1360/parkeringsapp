import '../models/vehicle.dart';

class VehicleRepository {
  static final VehicleRepository _instance = VehicleRepository._internal();

  VehicleRepository._internal();

  factory VehicleRepository() {
    return _instance;
  }

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

  List<Vehicle> getByOwner(String ownerPersonalNumber) {
    return _vehicles
        .where((v) => v.owner.personalNumber == ownerPersonalNumber)
        .toList();
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

  // Add this method to clear all vehicles from the repository
  void clear() {
    _vehicles.clear();
  }
}
