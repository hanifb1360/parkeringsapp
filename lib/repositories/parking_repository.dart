import '../models/parking.dart';

class ParkingRepository {
  /// Statisk instans av lagret

  static final ParkingRepository _instance = ParkingRepository._internal();

  /// Privat konstruktor

  ParkingRepository._internal();

  /// Fabrikkonstruktor för att returnera singleton-instansen

  factory ParkingRepository() {
    return _instance;
  }

  final List<Parking> _parkings = [];

  void add(Parking parking) {
    _parkings.add(parking);
  }

  List<Parking> getAll() {
    return _parkings;
  }

  Parking getByVehicleRegistration(String registrationNumber) {
    return _parkings.firstWhere(
      (p) => p.vehicle.registrationNumber == registrationNumber,
      orElse: () => throw Exception('Parking not found'),
    );
  }

  void update(Parking parking) {
    var index = _parkings.indexWhere((p) =>
        p.vehicle.registrationNumber == parking.vehicle.registrationNumber);
    if (index != -1) {
      _parkings[index] = parking;
    }
  }

  void delete(String registrationNumber) {
    _parkings
        .removeWhere((p) => p.vehicle.registrationNumber == registrationNumber);
  }

  // Add this method to clear the repository for testing
  void clear() {
    _parkings.clear();
  }
}
