import '../models/parking.dart';

class ParkingRepository {
  List<Parking> _parkings = [];

  void add(Parking parking) {
    _parkings.add(parking);
  }

  List<Parking> getAll() {
    return _parkings;
  }

  Parking? getByVehicleRegistration(String registrationNumber) {  // Note the return type is nullable (Parking?)
    return _parkings.firstWhere(
      (parking) => parking.vehicle.registrationNumber == registrationNumber,
      orElse: () => null,  // null can now be returned
    );
  }

  void update(Parking updatedParking) {
    if (_parkings == null) return;
    var index = _parkings.indexWhere((parking) => parking.vehicle.registrationNumber == updatedParking.vehicle.registrationNumber);
    if (index != -1) {
      _parkings[index] = updatedParking;
    }
  }

  void delete(String registrationNumber) {
    if (_parkings == null) return;
    _parkings.removeWhere((parking) => parking.vehicle.registrationNumber == registrationNumber);
  }
}
