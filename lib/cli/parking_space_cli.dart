import 'dart:io';
import '../repositories/parking_space_repository.dart';
import '../models/parking_space.dart';

void handleParkingSpaceCLI() {
  ParkingSpaceRepository parkingSpaceRepo = ParkingSpaceRepository();

  bool inParkingSpaceMenu = true;

  while (inParkingSpaceMenu) {
    print('Du har valt att hantera Parkeringsplatser. Vad vill du göra?');
    print('1. Skapa ny parkeringsplats');
    print('2. Visa alla parkeringsplatser');
    print('3. Uppdatera parkeringsplats');
    print('4. Ta bort parkeringsplats');
    print('5. Gå tillbaka till huvudmenyn');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createParkingSpace(parkingSpaceRepo);
        break;
      case '2':
        listParkingSpaces(parkingSpaceRepo);
        break;
      case '3':
        updateParkingSpace(parkingSpaceRepo);
        break;
      case '4':
        deleteParkingSpace(parkingSpaceRepo);
        break;
      case '5':
        inParkingSpaceMenu = false;
        break;
      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}

void createParkingSpace(ParkingSpaceRepository parkingSpaceRepo) {
  print('Ange adress:');
  String? address = stdin.readLineSync();

  print('Ange pris per timme:');
  String? priceInput = stdin.readLineSync();
  double? pricePerHour = double.tryParse(priceInput ?? '');

  if (address != null && pricePerHour != null) {
    int id = parkingSpaceRepo.getAll().length + 1; // Generate simple ID
    ParkingSpace newSpace = ParkingSpace(id: id, address: address, pricePerHour: pricePerHour);
    parkingSpaceRepo.add(newSpace);
    print('Parkeringsplats skapad: $newSpace');
  } else {
    print('Felaktig inmatning.');
  }
}

void listParkingSpaces(ParkingSpaceRepository parkingSpaceRepo) {
  List<ParkingSpace> spaces = parkingSpaceRepo.getAll();
  if (spaces.isEmpty) {
    print('Inga parkeringsplatser registrerade.');
  } else {
    spaces.forEach((space) => print(space));
  }
}

void updateParkingSpace(ParkingSpaceRepository parkingSpaceRepo) {
  print('Ange ID för parkeringsplatsen du vill uppdatera:');
  String? idInput = stdin.readLineSync();
  int? id = int.tryParse(idInput ?? '');

  ParkingSpace? space = parkingSpaceRepo.getById(id!);

  if (space != null) {
    print('Ange ny adress (tidigare: ${space.address}):');
    String? newAddress = stdin.readLineSync();

    print('Ange nytt pris per timme (tidigare: ${space.pricePerHour}):');
    String? newPriceInput = stdin.readLineSync();
    double? newPricePerHour = double.tryParse(newPriceInput ?? '');

    if (newAddress != null && newPricePerHour != null) {
      space.address = newAddress;
      space.pricePerHour = newPricePerHour;
      parkingSpaceRepo.update(space);
      print('Parkeringsplats uppdaterad: $space');
    } else {
      print('Felaktig inmatning.');
    }
  } else {
    print('Parkeringsplats hittades inte.');
  }
}

void deleteParkingSpace(ParkingSpaceRepository parkingSpaceRepo) {
  print('Ange ID för parkeringsplatsen du vill ta bort:');
  String? idInput = stdin.readLineSync();
  int? id = int.tryParse(idInput ?? '');

  if (id != null) {
    parkingSpaceRepo.delete(id);
    print('Parkeringsplats borttagen.');
  } else {
    print('Felaktig inmatning.');
  }
}

