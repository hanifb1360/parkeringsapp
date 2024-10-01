import 'dart:io';
import '../repositories/person_repository.dart';
import '../models/person.dart';

void managePersons() {
  final repository = PersonRepository(); // Singleton instance

  while (true) {
    // Display menu for managing persons
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
        // Create a new person
        stdout.write('Ange namn: ');
        var name = stdin.readLineSync();
        if (name == null || name.isEmpty) {
          print('Ogiltigt namn, försök igen.');
          continue;
        }
        stdout.write('Ange personnummer: ');
        var personalNumber = stdin.readLineSync();
        if (personalNumber == null || personalNumber.isEmpty) {
          print('Ogiltigt personnummer, försök igen.');
          continue;
        }
        var person = Person(name: name, personalNumber: personalNumber);
        repository.add(person);
        print('Person skapad: $person');
        break;
      case '2':
        // Display all registered persons
        var persons = repository.getAll();
        if (persons.isEmpty) {
          print('Inga personer registrerade.');
        } else {
          for (var person in persons) {
            print(person);
          }
        }
        break;
      case '3':
        // Update an existing person
        stdout.write('Ange personnummer för den person du vill uppdatera: ');
        var personalNumber = stdin.readLineSync();
        if (personalNumber == null || personalNumber.isEmpty) {
          print('Ogiltigt personnummer, försök igen.');
          continue;
        }
        var person = repository.getById(personalNumber);
        // No need for null-check here, because the person cannot be null
        stdout.write('Ange nytt namn: ');
        var newName = stdin.readLineSync();
        if (newName == null || newName.isEmpty) {
          print('Ogiltigt namn, försök igen.');
          continue;
        }
        person.name = newName;
        repository.update(person);
        print('Person uppdaterad: $person');
        break;
      case '4':
        // Delete a person
        stdout.write('Ange personnummer för den person du vill ta bort: ');
        var personalNumber = stdin.readLineSync();
        if (personalNumber == null || personalNumber.isEmpty) {
          print('Ogiltigt personnummer, försök igen.');
          continue;
        }
        repository.delete(personalNumber);
        print('Person borttagen.');
        break;
      case '5':
        // Go back to the main menu
        return;
      default:
        // Invalid option
        print('Ogiltigt val, försök igen.');
    }
  }
}
