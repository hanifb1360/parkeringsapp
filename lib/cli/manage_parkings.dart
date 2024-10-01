import 'dart:io';
import '../repositories/parking_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/parking_space_repository.dart';
import '../models/parking.dart';

// Function for managing parkings
void manageParkings() {
  final parkingRepo = ParkingRepository(); // Singleton instance
  final vehicleRepo = VehicleRepository(); // Singleton instance
  final parkingSpaceRepo = ParkingSpaceRepository(); // Singleton instance

  print('\nDu har valt att hantera Parkeringar.');
  print('1. Skapa ny parkering');
  print('2. Visa alla parkeringar');
  print('3. Uppdatera parkering');
  print('4. Ta bort parkering');
  print('5. Gå tillbaka till huvudmenyn');
  stdout.write('Välj ett alternativ (1-5): ');
  var choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      // Create new parking
      stdout.write('Ange fordonets registreringsnummer: ');
      var regNumber = stdin.readLineSync();
      var vehicle = vehicleRepo.getByRegistrationNumber(regNumber!);
      stdout.write('Ange parkeringsplatsens ID: ');
      var parkingSpaceId = stdin.readLineSync();
      var parkingSpace = parkingSpaceRepo.getById(parkingSpaceId!);
      var parking = Parking(
          vehicle: vehicle,
          parkingSpace: parkingSpace,
          startTime: DateTime.now(),
          endTime: null);
      parkingRepo.add(parking);
      print('Parkering skapad: $parking');
      break;

    case '2':
      // View all parkings
      var parkings = parkingRepo.getAll();
      if (parkings.isEmpty) {
        print('Inga parkeringar registrerade.');
      } else {
        for (var parking in parkings) {
          print(parking);
        }
      }
      break;

    case '3':
      // Update and end parking
      stdout.write(
          'Ange fordonets registreringsnummer för den parkering du vill uppdatera: ');
      var regNumber = stdin.readLineSync();
      var parking = parkingRepo.getByVehicleRegistration(regNumber!);
      if (parking != null) {
        stdout.write('Vill du avsluta parkeringen? (j/n): ');
        var shouldEnd = stdin.readLineSync();
        if (shouldEnd == 'j') {
          endParking(parking);
        } else {
          print('Parkeringen avslutas inte.');
        }
      } else {
        print('Ingen parkering hittades för det fordonet.');
      }
      break;

    case '4':
      // Delete parking
      stdout.write(
          'Ange fordonets registreringsnummer för den parkering du vill ta bort: ');
      var regNumber = stdin.readLineSync();
      parkingRepo.delete(regNumber!);
      print('Parkering borttagen.');
      break;

    case '5':
      // Go back to main menu
      return;

    default:
      print('Ogiltigt val, försök igen.');
  }
}

// Function to end a parking and calculate the cost
void endParking(Parking parking) {
  final parkingRepo = ParkingRepository(); // Singleton instance
  parking.endTime = DateTime.now(); // Set end time to now
  parkingRepo.update(parking); // Update parking in the repository
  print('Parkering avslutad.');

  // Calculate the cost
  double cost = parking.calculateCost();
  print('Total kostnad: $cost SEK');
}
