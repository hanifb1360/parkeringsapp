import '../models/person.dart';
import 'package:parkeringsapp/cli/person_cli.dart';
import '../repositories/person_repository.dart';
import '../models/vehicle.dart';

class PersonRepository {
  List<Person> _persons = [];

  void add(Person person) {
    _persons.add(person);
  }

  List<Person> getAll() {
    return _persons;
  }

  Person? getByPersonalNumber(String personalNumber) {
    return _persons.firstWhere(
      (person) => person.personalNumber == personalNumber,
      orElse: () => Person(personalNumber: ''),  // Return a default Person object
    );
  }

  void update(Person updatedPerson) {
    var index = _persons.indexWhere(
      (person) => person.personalNumber == updatedPerson.personalNumber,
    );
    if (index != -1) {
      _persons[index] = updatedPerson;
    }
  }

  void delete(String personalNumber) {
    _persons.removeWhere((person) => person.personalNumber == personalNumber);
  }
}

class VehicleRepository {
  List<Vehicle> _vehicles = [];

  void add(Vehicle vehicle) {
    _vehicles.add(vehicle);
  }

  List<Vehicle> getAll() {
    return _vehicles;
  }

  Vehicle? getByRegistrationNumber(String registrationNumber) {
    return _vehicles.firstWhere(
      (vehicle) => vehicle.registrationNumber == registrationNumber,
      orElse: () => Vehicle(registrationNumber: '', type: '', owner: Person(personalNumber: '')),  // Return a default Vehicle object
    );
  }
}

class ParkingSpaceRepository {
  List<ParkingSpace> _parkingSpaces = [];

  void add(ParkingSpace parkingSpace) {
    _parkingSpaces.add(parkingSpace);
  }

  List<ParkingSpace> getAll() {
    return _parkingSpaces;
  }

  ParkingSpace? getById(String id) {
    return _parkingSpaces.firstWhere(
      (parkingSpace) => parkingSpace.id == id,
      orElse: () => ParkingSpace(id: '', location: ''),  // Return a default ParkingSpace object
    );
  }
}

import '../models/parking.dart';

class ParkingRepository {
  List<Parking> _parkings = [];

  void add(Parking parking) {
    _parkings.add(parking);
  }

  List<Parking> getAll() {
    return _parkings;
  }

  Parking? getById(String id) {
    return _parkings.firstWhere(
      (parking) => parking.id == id,
      orElse: () => Parking(id: '', vehicle: Vehicle(registrationNumber: '', type: '', owner: Person(personalNumber: ''))),  // Return a default Parking object
    );
  }
}
