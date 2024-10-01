import 'dart:io';
import '../repositories/vehicle_repository.dart';
import '../repositories/person_repository.dart';
import '../models/vehicle.dart';

void manageVehicles(
    VehicleRepository vehicleRepo, PersonRepository personRepo) {
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
      // Skapa nytt fordon
      stdout.write('Ange registreringsnummer: ');
      var registrationNumber = stdin.readLineSync();
      if (registrationNumber == null || registrationNumber.isEmpty) {
        print('Registreringsnummer kan inte vara tomt.');
        break;
      }
      stdout.write('Ange typ (bil, motorcykel, etc.): ');
      var type = stdin.readLineSync();
      if (type == null || type.isEmpty) {
        print('Typ kan inte vara tomt.');
        break;
      }
      stdout.write('Ange ägarens personnummer: ');
      var ownerPersonalNumber = stdin.readLineSync();
      if (ownerPersonalNumber == null || ownerPersonalNumber.isEmpty) {
        print('Personnummer kan inte vara tomt.');
        break;
      }
      var owner = personRepo.getById(ownerPersonalNumber);
      // Ägaren kan inte vara null, så ingen kontroll för null behövs
      var vehicle = Vehicle(
          registrationNumber: registrationNumber, type: type, owner: owner);
      vehicleRepo.add(vehicle);
      print('Fordon skapad: $vehicle');
      break;
    case '2':
      // Visa alla fordon
      var vehicles = vehicleRepo.getAll();
      if (vehicles.isEmpty) {
        print('Inga fordon registrerade.');
      } else {
        for (var vehicle in vehicles) {
          print(vehicle);
        }
      }
      break;
    case '3':
      // Uppdatera fordon
      stdout
          .write('Ange registreringsnummer för det fordon du vill uppdatera: ');
      var registrationNumber = stdin.readLineSync();
      if (registrationNumber == null || registrationNumber.isEmpty) {
        print('Registreringsnummer kan inte vara tomt.');
        break;
      }
      var vehicle = vehicleRepo.getByRegistrationNumber(registrationNumber);
      print(
          'Fordon med registreringsnummer $registrationNumber hittades inte.');
      stdout.write('Ange ny typ (bil, motorcykel, etc.): ');
      var newType = stdin.readLineSync();
      if (newType == null || newType.isEmpty) {
        print('Typ kan inte vara tomt.');
        break;
      }
      vehicle.type = newType;
      vehicleRepo.update(vehicle);
      print('Fordon uppdaterad: $vehicle');
      break;
    case '4':
      // Ta bort fordon
      stdout.write('Ange registreringsnummer för det fordon du vill ta bort: ');
      var registrationNumber = stdin.readLineSync();
      if (registrationNumber == null || registrationNumber.isEmpty) {
        print('Registreringsnummer kan inte vara tomt.');
        break;
      }
      var vehicle = vehicleRepo.getByRegistrationNumber(registrationNumber);
      if (vehicle == null) {
        print(
            'Fordon med registreringsnummer $registrationNumber hittades inte.');
        break;
      }
      vehicleRepo.delete(registrationNumber);
      print('Fordon borttagen.');
      break;
    case '5':
      // Gå tillbaka till huvudmenyn
      return;
    default:
      // Ogiltigt val
      print('Ogiltigt val, försök igen.');
  }
}
