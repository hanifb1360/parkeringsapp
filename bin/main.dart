import 'dart:io';
import '../lib/cli/person_cli.dart';
import '../lib/cli/vehicle_cli.dart';
import '../lib/cli/parking_space_cli.dart';
import '../lib/cli/parking_cli.dart';

void main() {
  bool running = true;

  while (running) {
    print('Välkommen till Parkeringsappen!');
    print('Vad vill du hantera?');
    print('1. Personer');
    print('2. Fordon');
    print('3. Parkeringsplatser');
    print('4. Parkeringar');
    print('5. Avsluta');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        handlePersonCLI();
        break;
      case '2':
        handleVehicleCLI();
        break;
      case '3':
        handleParkingSpaceCLI();
        break;
      case '4':
        handleParkingCLI();
        break;
      case '5':
        running = false;
        print('Avslutar programmet.');
        break;
      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}
