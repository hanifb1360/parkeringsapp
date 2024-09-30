import '../models/person.dart';

class PersonRepository {
  final List<Person> _persons = [];

  void add(Person person) {
    _persons.add(person);
  }

  List<Person> getAll() {
    return _persons;
  }

  Person? getByPersonalNumber(String personalNumber) {
    return _persons.firstWhere((person) => person.personalNumber == personalNumber, orElse: () => null);
  }

  void update(Person person) {
    var index = _persons.indexWhere((p) => p.personalNumber == person.personalNumber);
    if (index != -1) {
      _persons[index] = person;
    }
  }

  void delete(String personalNumber) {
    _persons.removeWhere((person) => person.personalNumber == personalNumber);
  }
}
