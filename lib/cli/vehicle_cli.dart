import 'dart:io';
import '../models/vehicle.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/person_repository.dart';

void handleVehicleCLI() {
  VehicleRepository vehicleRepo = VehicleRepository();
  PersonRepository personRepo = PersonRepository(); // You'll need this to assign owners to vehicles

  bool inVehicleMenu = true;

  while (inVehicleMenu) {
    print('Du har valt att hantera Fordon. Vad vill du göra?');
    print('1. Skapa nytt fordon');
    print('2. Visa alla fordon');
    print('3. Uppdatera fordon');
    print('4. Ta bort fordon');
    print('5. Gå tillbaka till huvudmenyn');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createVehicle(vehicleRepo, personRepo);
        break;
      case '2':
        listVehicles(vehicleRepo);
        break;
      case '3':
        updateVehicle(vehicleRepo);
        break;
      case '4':
        deleteVehicle(vehicleRepo);
        break;
      case '5':
        inVehicleMenu = false;
        break;
      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}

void createVehicle(VehicleRepository vehicleRepo, PersonRepository personRepo) {
  print('Ange registreringsnummer:');
  String? regNumber = stdin.readLineSync();

  print('Ange fordonstyp (t.ex. bil, motorcykel):');
  String? type = stdin.readLineSync();

  print('Ange personnummer för ägaren:');
  String? ownerPersonalNumber = stdin.readLineSync();

  var owner = personRepo.getByPersonalNumber(ownerPersonalNumber!);
  if (owner != null && regNumber != null && type != null) {
    Vehicle newVehicle = Vehicle(registrationNumber: regNumber, type: type, owner: owner);
    vehicleRepo.add(newVehicle);
    print('Fordon skapat: $newVehicle');
  } else {
    print('Felaktig inmatning eller ägare hittades inte.');
  }
}

void listVehicles(VehicleRepository vehicleRepo) {
  List<Vehicle> vehicles = vehicleRepo.getAll();
  if (vehicles.isEmpty) {
    print('Inga fordon registrerade.');
  } else {
    vehicles.forEach((vehicle) => print(vehicle));
  }
}

void updateVehicle(VehicleRepository vehicleRepo) {
  print('Ange registreringsnummer för fordonet du vill uppdatera:');
  String? regNumber = stdin.readLineSync();

  Vehicle? vehicle = vehicleRepo.getByRegistration(regNumber!);

  if (vehicle != null) {
    print('Ange ny fordonstyp (tidigare: ${vehicle.type}):');
    String? newType = stdin.readLineSync();

    if (newType != null) {
      vehicle.type = newType;
      vehicleRepo.update(vehicle);
      print('Fordon uppdaterat: $vehicle');
    } else {
      print('Felaktig inmatning.');
    }
  } else {
    print('Fordon hittades inte.');
  }
}

void deleteVehicle(VehicleRepository vehicleRepo) {
  print('Ange registreringsnummer för fordonet du vill ta bort:');
  String? regNumber = stdin.readLineSync();

  vehicleRepo.delete(regNumber!);
  print('Fordon borttaget.');
}
