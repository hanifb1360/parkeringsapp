import 'dart:io';
import '../repositories/parking_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/parking_space_repository.dart';
import '../models/parking.dart';

void manageParkings(ParkingRepository parkingRepo, VehicleRepository vehicleRepo, ParkingSpaceRepository parkingSpaceRepo) {
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
      stdout.write('Ange fordonets registreringsnummer: ');
      var regNumber = stdin.readLineSync();
      var vehicle = vehicleRepo.getByRegistrationNumber(regNumber!);
      if (vehicle != null) {
        stdout.write('Ange parkeringsplatsens ID: ');
        var parkingSpaceId = stdin.readLineSync();
        var parkingSpace = parkingSpaceRepo.getById(parkingSpaceId!);
        if (parkingSpace != null) {
          var parking = Parking(vehicle: vehicle, parkingSpace: parkingSpace, startTime: DateTime.now(), endTime: null);
          parkingRepo.add(parking);
          print('Parkering skapad: $parking');
        } else {
          print('Ingen parkeringsplats hittades med det ID:et.');
        }
      } else {
        print('Inget fordon hittades med det registreringsnumret.');
      }
      break;
    case '2':
      var parkings = parkingRepo.getAll();
      if (parkings.isEmpty) {
        print('Inga parkeringar registrerade.');
      } else {
        parkings.forEach((parking) => print(parking));
      }
      break;
    case '3':
      stdout.write('Ange fordonets registreringsnummer för den parkering du vill uppdatera: ');
      var regNumber = stdin.readLineSync();
      var parking = parkingRepo.getByVehicleRegistration(regNumber!);
      if (parking != null) {
        stdout.write('Vill du avsluta parkeringen? (j/n): ');
        var shouldEnd = stdin.readLineSync();
        if (shouldEnd == 'j') {
          parking.endTime = DateTime.now();
          parkingRepo.update(parking);
          print('Parkering uppdaterad: $parking');
        }
      } else {
        print('Ingen parkering hittades för det fordonet.');
      }
      break;
    case '4':
      stdout.write('Ange fordonets registreringsnummer för den parkering du vill ta bort: ');
      var regNumber = stdin.readLineSync();
      parkingRepo.delete(regNumber!);
      print('Parkering borttagen.');
      break;
    case '5':
      return;
    default:
      print('Ogiltigt val, försök igen.');
  }
}
