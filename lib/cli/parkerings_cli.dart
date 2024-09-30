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
        // Call the manageParkingSpaces() function here when implemented
        break;
      case '4':
        // Call the manageParkings() function here when implemented
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
