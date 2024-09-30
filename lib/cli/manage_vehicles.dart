import 'dart:io';
import '../repositories/vehicle_repository.dart';
import '../repositories/person_repository.dart';
import '../models/vehicle.dart';

void manageVehicles(VehicleRepository vehicleRepo, PersonRepository personRepo) {
  print('\nDu har valt att hantera Fordon.');
  print('1. Skapa nytt fordon');
  print('2. Visa alla fordon');
  print('3. Uppdatera fordon');
  print('4. Ta bort fordon');
  print('5. Gå tillbaka till huvudmenyn');
  stdout.write('Välj ett alternativ (1-5): ');
  var choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      stdout.write('Ange registreringsnummer: ');
      var registrationNumber = stdin.readLineSync();
      stdout.write('Ange typ (bil, motorcykel, etc.): ');
      var type = stdin.readLineSync();
      stdout.write('Ange ägarens personnummer: ');
      var ownerPersonalNumber = stdin.readLineSync();
      var owner = personRepo.getById(ownerPersonalNumber!);
      if (owner != null) {
        var vehicle = Vehicle(registrationNumber: registrationNumber!, type: type!, owner: owner);
        vehicleRepo.add(vehicle);
        print('Fordon skapad: $vehicle');
      } else {
        print('Ägare med det angivna personnumret hittades inte.');
      }
      break;
    case '2':
      var vehicles = vehicleRepo.getAll();
      if (vehicles.isEmpty) {
        print('Inga fordon registrerade.');
      } else {
        vehicles.forEach((vehicle) => print(vehicle));
      }
      break;
    case '3':
      stdout.write('Ange registreringsnummer för det fordon du vill uppdatera: ');
      var registrationNumber = stdin.readLineSync();
      var vehicle = vehicleRepo.getByRegistrationNumber(registrationNumber!);
      if (vehicle != null) {
        stdout.write('Ange ny typ (bil, motorcykel, etc.): ');
        var newType = stdin.readLineSync();
        vehicle.type = newType!;
        vehicleRepo.update(vehicle);
        print('Fordon uppdaterad: $vehicle');
      } else {
        print('Inget fordon hittades med det registreringsnumret.');
      }
      break;
    case '4':
      stdout.write('Ange registreringsnummer för det fordon du vill ta bort: ');
      var registrationNumber = stdin.readLineSync();
      vehicleRepo.delete(registrationNumber!);
      print('Fordon borttagen.');
      break;
    case '5':
      return;
    default:
      print('Ogiltigt val, försök igen.');
  }
}
