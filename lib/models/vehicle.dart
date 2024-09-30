import 'person.dart';

class Vehicle {
  String registrationNumber;
  String type; // 'Car', 'Motorcycle', etc.
  Person owner; // The owner is a Person object

  Vehicle({required this.registrationNumber, required this.type, required this.owner});

  @override
  String toString() {
    return 'Vehicle(registrationNumber: $registrationNumber, type: $type, owner: ${owner.name})';
  }
}
