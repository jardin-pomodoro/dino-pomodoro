import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dino_app/domain/models/person.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonsDataModel extends ChangeNotifier {
  final List<Person> _persons = [];

  int get count => _persons.length;

  UnmodifiableListView<Person> get persons => UnmodifiableListView(_persons);

  void add(Person person) {
    _persons.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _persons.remove(person);
    notifyListeners();
  }

  void update(Person updatedPerson) {
    final index = _persons.indexOf(updatedPerson);
    final oldPerson = _persons[index];
    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      _persons[index] = oldPerson.updated(
        name: updatedPerson.name,
        age: updatedPerson.age,
      );
      notifyListeners();
    }

    notifyListeners();
  }
}

final peopleProvider =
    ChangeNotifierProvider<PersonsDataModel>((_) => PersonsDataModel());