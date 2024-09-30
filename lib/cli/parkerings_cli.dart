import 'dart:io';
import '../repositories/person_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/parking_space_repository.dart';
import '../repositories/parking_repository.dart';
import '../models/person.dart';
import '../models/vehicle.dart';

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

void managePersons(PersonRepository repository) {
  print('\nDu har valt att hantera Personer.');
  print('1. Skapa ny person');
  print('2. Visa alla personer');
  print('3. Uppdatera person');
  print('4. Ta bort person');
  print('5. Gå tillbaka till huvudmenyn');
  stdout.write('Välj ett alternativ (1-5): ');
  var choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      stdout.write('Ange namn: ');
      var name = stdin.readLineSync();
      stdout.write('Ange personnummer: ');
      var personalNumber = stdin.readLineSync();
      var person = Person(name: name!, personalNumber: personalNumber!);
      repository.add(person);
      print('Person skapad: $person');
      break;
    case '2':
      var persons = repository.getAll();
      if (persons.isEmpty) {
        print('Inga personer registrerade.');
      } else {
        persons.forEach((person) => print(person));
      }
      break;
    case '3':
      stdout.write('Ange personnummer för den person du vill uppdatera: ');
      var personalNumber = stdin.readLineSync();
      var person = repository.getById(personalNumber!);
      if (person != null) {
        stdout.write('Ange nytt namn: ');
        var newName = stdin.readLineSync();
        person.name = newName!;
        repository.update(person);
        print('Person uppdaterad: $person');
      } else {
        print('Ingen person hittades med det personnumret.');
      }
      break;
    case '4':
      stdout.write('Ange personnummer för den person du vill ta bort: ');
      var personalNumber = stdin.readLineSync();
      repository.delete(personalNumber!);
      print('Person borttagen.');
      break;
    case '5':
      return;
    default:
      print('Ogiltigt val, försök igen.');
  }
}

void manageVehicles(VehicleRepository vehicleRepo, PersonRepository personRepo) {
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
      stdout.write('Ange registreringsnummer: ');
      var registrationNumber = stdin.readLineSync();
      stdout.write('Ange typ (bil, motorcykel, etc.): ');
      var type = stdin.readLineSync();
      stdout.write('Ange ägarens personnummer: ');
      var ownerPersonalNumber = stdin.readLineSync();
      var owner = personRepo.getById(ownerPersonalNumber!);
      if (owner != null) {
        var vehicle = Vehicle(registrationNumber: registrationNumber!, type: type!, owner: owner);
        vehicleRepo.add(vehicle);
        print('Fordon skapad: $vehicle');
      } else {
        print('Ägare med det angivna personnumret hittades inte.');
      }
      break;
    case '2':
      var vehicles = vehicleRepo.getAll();
      if (vehicles.isEmpty) {
        print('Inga fordon registrerade.');
      } else {
        vehicles.forEach((vehicle) => print(vehicle));
      }
      break;
    case '3':
      stdout.write('Ange registreringsnummer för det fordon du vill uppdatera: ');
      var registrationNumber = stdin.readLineSync();
      var vehicle = vehicleRepo.getByRegistrationNumber(registrationNumber!);
      if (vehicle != null) {
        stdout.write('Ange ny typ (bil, motorcykel, etc.): ');
        var newType = stdin.readLineSync();
        vehicle.type = newType!;
        vehicleRepo.update(vehicle);
        print('Fordon uppdaterad: $vehicle');
      } else {
        print('Inget fordon hittades med det registreringsnumret.');
      }
      break;
    case '4':
      stdout.write('Ange registreringsnummer för det fordon du vill ta bort: ');
      var registrationNumber = stdin.readLineSync();
      vehicleRepo.delete(registrationNumber!);
      print('Fordon borttagen.');
      break;
    case '5':
      return;
    default:
      print('Ogiltigt val, försök igen.');
  }
}

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
