import 'dart:io';

// Import the separated CLI management files
import 'manage_persons.dart';
import 'manage_vehicles.dart';
import 'manage_parking_spaces.dart';
import 'manage_parkings.dart';

void runCLI() {
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
        managePersons(); // No arguments needed here
        break;
      case '2':
        manageVehicles(); // No arguments needed here
        break;
      case '3':
        manageParkingSpaces(); // No arguments needed here
        break;
      case '4':
        manageParkings(); // No arguments needed here
        break;
      case '5':
        print('Avslutar...');
        return;
      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}
