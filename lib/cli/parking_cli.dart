import 'dart:io';
import '../models/parking.dart';
import '../repositories/parking_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/parking_space_repository.dart';

void handleParkingCLI() {
  ParkingRepository parkingRepo = ParkingRepository();
  VehicleRepository vehicleRepo = VehicleRepository();
  ParkingSpaceRepository parkingSpaceRepo = ParkingSpaceRepository();

  bool inParkingMenu = true;

  while (inParkingMenu) {
    print('Du har valt att hantera Parkeringar. Vad vill du göra?');
    print('1. Skapa ny parkering');
    print('2. Visa alla parkeringar');
    print('3. Uppdatera parkering');
    print('4. Ta bort parkering');
    print('5. Gå tillbaka till huvudmenyn');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createParking(parkingRepo, vehicleRepo, parkingSpaceRepo);
        break;
      case '2':
        listParkings(parkingRepo);
        break;
      case '3':
        updateParking(parkingRepo);
        break;
      case '4':
        deleteParking(parkingRepo);
        break;
      case '5':
        inParkingMenu = false;
        break;
      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}

void createParking(
  ParkingRepository parkingRepo,
  VehicleRepository vehicleRepo,
  ParkingSpaceRepository parkingSpaceRepo,
) {
  print('Ange registreringsnummer för fordonet:');
  String? regNumber = stdin.readLineSync();

  var vehicle = vehicleRepo.getByRegistration(regNumber!);
  if (vehicle == null) {
    print('Fordonet hittades inte.');
    return;
  }

  print('Ange ID för parkeringsplatsen:');
  String? parkingSpaceIdInput = stdin.readLineSync();
  int? parkingSpaceId = int.tryParse(parkingSpaceIdInput ?? '');

  var parkingSpace = parkingSpaceRepo.getById(parkingSpaceId!);
  if (parkingSpace == null) {
    print('Parkeringsplatsen hittades inte.');
    return;
  }

  DateTime startTime = DateTime.now();
  Parking newParking = Parking(vehicle: vehicle, parkingSpace: parkingSpace, startTime: startTime);
  parkingRepo.add(newParking);
  print('Parkering skapad: $newParking');
}

void listParkings(ParkingRepository parkingRepo) {
  List<Parking> parkings = parkingRepo.getAll();
  if (parkings.isEmpty) {
    print('Inga parkeringar registrerade.');
  } else {
    parkings.forEach((parking) => print(parking));
  }
}

void updateParking(ParkingRepository parkingRepo) {
  print('Ange registreringsnummer för parkeringen du vill uppdatera:');
  String? regNumber = stdin.readLineSync();

  Parking? parking = parkingRepo.getByVehicleRegistration(regNumber!);

  if (parking != null) {
    print('Ange sluttid för parkeringen (tidigare sluttid: ${parking.endTime ?? "Pågående"}):');
    String? newEndTimeInput = stdin.readLineSync();
    DateTime? newEndTime = DateTime.tryParse(newEndTimeInput!);

    if (newEndTime != null) {
      parking.endTime = newEndTime;
      parkingRepo.update(parking);
      print('Parkering uppdaterad: $parking');
    } else {
      print('Felaktig inmatning.');
    }
  } else {
    print('Parkeringen hittades inte.');
  }
}

void deleteParking(ParkingRepository parkingRepo) {
  print('Ange registreringsnummer för parkeringen du vill ta bort:');
  String? regNumber = stdin.readLineSync();

  parkingRepo.delete(regNumber!);
  print('Parkering borttagen.');
}
