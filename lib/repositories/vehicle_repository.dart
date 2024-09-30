import '../models/vehicle.dart';

class VehicleRepository {
  List<Vehicle> _vehicles = [];

  void add(Vehicle vehicle) {
    _vehicles.add(vehicle);
  }

  List<Vehicle> getAll() {
    return _vehicles;
  }

  Vehicle? getByRegistration(String registrationNumber) {  // Note the return type is nullable (Vehicle?)
    return _vehicles.firstWhere(
      (vehicle) => vehicle.registrationNumber == registrationNumber,
      orElse: () => null,  // null can now be returned
    );
  }

  void update(Vehicle updatedVehicle) {
    var index = _vehicles.indexWhere(
      (vehicle) => vehicle.registrationNumber == updatedVehicle.registrationNumber,
    );
    if (index != -1) {
      _vehicles[index] = updatedVehicle;
    }
  }

  void delete(String registrationNumber) {
    _vehicles.removeWhere((vehicle) => vehicle.registrationNumber == registrationNumber);
  }
}
