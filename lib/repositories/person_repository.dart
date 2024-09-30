import '../models/person.dart';

class PersonRepository {
  final List<Person> _persons = [];

  void add(Person person) {
    _persons.add(person);
  }

  List<Person> getAll() {
    return _persons;
  }

  Person getById(String personalNumber) {
    return _persons.firstWhere(
      (p) => p.personalNumber == personalNumber,
      orElse: () => throw Exception('Person not found'),
    );
  }

  void update(Person person) {
    var index = _persons.indexWhere((p) => p.personalNumber == person.personalNumber);
    if (index != -1) {
      _persons[index] = person;
    }
  }

  void delete(String personalNumber) {
    _persons.removeWhere((p) => p.personalNumber == personalNumber);
  }
}
