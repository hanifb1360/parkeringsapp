import '../models/parking_space.dart';

class ParkingSpaceRepository {
  List<ParkingSpace> _parkingSpaces = [];

  void add(ParkingSpace parkingSpace) {
    _parkingSpaces.add(parkingSpace);
  }

  List<ParkingSpace> getAll() {
    return _parkingSpaces;
  }

  ParkingSpace? getById(int id) {  // Note the return type is nullable (ParkingSpace?)
    return _parkingSpaces.firstWhere(
      (space) => space.id == id,
      orElse: () => null,  // null can now be returned
    );
  }

  void update(ParkingSpace updatedSpace) {
    var index = _parkingSpaces.indexWhere(
      (space) => space.id == updatedSpace.id,
    );
    if (index != -1) {
      _parkingSpaces[index] = updatedSpace;
    }
  }

  void delete(int id) {
    _parkingSpaces.removeWhere((space) => space.id == id);
  }
}
