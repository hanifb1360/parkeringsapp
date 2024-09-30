import 'dart:io';
import '../repositories/person_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/parking_space_repository.dart';
import '../repositories/parking_repository.dart';

// Import the separated CLI management files
import 'manage_persons.dart';
import 'manage_vehicles.dart';
import 'manage_parking_spaces.dart';
import 'manage_parkings.dart';

void runCLI() {
  final personRepository = PersonRepository();
  final vehicleRepository = VehicleRepository();
  final parkingSpaceRepository = ParkingSpaceRepository();
  final parkingRepository = ParkingRepository();

  while (true) {
    print('\nVälkommen till Parkeringsappen!');
    print('Vad vill du hantera?');
    print('1. Personer');
    print('2. Fordon');
    print('3. Parkeringsplatser');
    print('4. Parkeringar');
    print('5. Avsluta');
    stdout.write('Välj ett alternativ (1-5): ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        managePersons(personRepository);
        break;
      case '2':
        manageVehicles(vehicleRepository, personRepository);
        break;
      case '3':
        manageParkingSpaces(parkingSpaceRepository);
        break;
      case '4':
        manageParkings(parkingRepository, vehicleRepository, parkingSpaceRepository);
        break;
      case '5':
        print('Avslutar...');
        return;
      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}
