import 'dart:io';
import '../repositories/vehicle_repository.dart';
import '../repositories/person_repository.dart';
import 'vehicle_search.dart';
import '../models/vehicle.dart';

void manageVehicles() {
  final vehicleRepo = VehicleRepository(); // Singleton instance
  final personRepo = PersonRepository(); // Singleton instance

  print('\nDu har valt att hantera Fordon.');
  print('1. Skapa nytt fordon');
  print('2. Visa alla fordon');
  print('3. Uppdatera fordon');
  print('4. Ta bort fordon');
  print('5. Sök fordon efter ägare');
  print('6. Gå tillbaka till huvudmenyn');
  stdout.write('Välj ett alternativ (1-6): ');
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
      var vehicle = Vehicle(
          registrationNumber: registrationNumber!, type: type!, owner: owner);
      vehicleRepo.add(vehicle);
      print('Fordon skapad: $vehicle');
      break;

    case '2':
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
      stdout
          .write('Ange registreringsnummer för det fordon du vill uppdatera: ');
      var registrationNumber = stdin.readLineSync();
      var vehicle = vehicleRepo.getByRegistrationNumber(registrationNumber!);
      stdout.write('Ange ny typ (bil, motorcykel, etc.): ');
      var newType = stdin.readLineSync();
      vehicle.type = newType!;
      vehicleRepo.update(vehicle);
      print('Fordon uppdaterad: $vehicle');
      break;

    case '4':
      stdout.write('Ange registreringsnummer för det fordon du vill ta bort: ');
      var registrationNumber = stdin.readLineSync();
      vehicleRepo.delete(registrationNumber!);
      print('Fordon borttagen.');
      break;

    case '5':
      // Call the search function to find vehicles by owner
      searchVehiclesByOwner(vehicleRepo);
      break;

    case '6':
      return;

    default:
      print('Ogiltigt val, försök igen.');
  }
}
