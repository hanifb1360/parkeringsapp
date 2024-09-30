import 'dart:io';
import '../repositories/parking_space_repository.dart';
import '../models/parking_space.dart';

void manageParkingSpaces(ParkingSpaceRepository repository) {
  print('\nDu har valt att hantera Parkeringsplatser.');
  print('1. Skapa ny parkeringsplats');
  print('2. Visa alla parkeringsplatser');
  print('3. Uppdatera parkeringsplats');
  print('4. Ta bort parkeringsplats');
  print('5. Gå tillbaka till huvudmenyn');
  stdout.write('Välj ett alternativ (1-5): ');
  var choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      stdout.write('Ange ID: ');
      var id = stdin.readLineSync();
      stdout.write('Ange adress: ');
      var address = stdin.readLineSync();
      stdout.write('Ange pris per timme: ');
      var pricePerHour = double.tryParse(stdin.readLineSync() ?? '0');
      var parkingSpace = ParkingSpace(id: id!, address: address!, pricePerHour: pricePerHour!);
      repository.add(parkingSpace);
      print('Parkeringsplats skapad: $parkingSpace');
      break;
    case '2':
      var parkingSpaces = repository.getAll();
      if (parkingSpaces.isEmpty) {
        print('Inga parkeringsplatser registrerade.');
      } else {
        parkingSpaces.forEach((parkingSpace) => print(parkingSpace));
      }
      break;
    case '3':
      stdout.write('Ange ID för den parkeringsplats du vill uppdatera: ');
      var id = stdin.readLineSync();
      var parkingSpace = repository.getById(id!);
      if (parkingSpace != null) {
        stdout.write('Ange ny adress: ');
        var newAddress = stdin.readLineSync();
        stdout.write('Ange nytt pris per timme: ');
        var newPricePerHour = double.tryParse(stdin.readLineSync() ?? '0');
        parkingSpace.address = newAddress!;
        parkingSpace.pricePerHour = newPricePerHour!;
        repository.update(parkingSpace);
        print('Parkeringsplats uppdaterad: $parkingSpace');
      } else {
        print('Ingen parkeringsplats hittades med det ID:et.');
      }
      break;
    case '4':
      stdout.write('Ange ID för den parkeringsplats du vill ta bort: ');
      var id = stdin.readLineSync();
      repository.delete(id!);
      print('Parkeringsplats borttagen.');
      break;
    case '5':
      return;
    default:
      print('Ogiltigt val, försök igen.');
  }
}
