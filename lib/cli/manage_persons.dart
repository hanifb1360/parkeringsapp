import 'dart:io';
import '../repositories/person_repository.dart';
import '../models/person.dart';

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
