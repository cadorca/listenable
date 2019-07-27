import 'package:listenable/listenable.dart';
import 'package:flutter/foundation.dart';

part 'phonebook_models.g.dart';

enum Gender { MALE, FEMALE }

class Person = _Person with _Person$Listenable;

@ListenableModel()
abstract class _Person {
  @ListenableProperty()
  String name;
  @ListenableProperty()
  String cellPhone;
  @ListenableProperty()
  double age = 0;
  Gender gender;
  @ListenableProperty()
  bool favorite = false;

  @override
  String toString() {
    return '_Person{name: $name, cellPhone: $cellPhone, age: $age, gender: $gender, favorite: $favorite}';
  }
}

class PhoneBookController = _PhoneBookController with _PhoneBookController$Listenable;

@ListenableModel()
abstract class _PhoneBookController {
  @ListenableProperty()
  double age = 0;

  @ListenableProperty(alwaysFireChangeEvent: true)
  List<Person> contacts = List<Person>();

  @ListenableProperty()
  Person currentPerson = Person();

  void newContact() {
    currentPerson = Person();
  }

  void addContact() {
    contacts.add(currentPerson);
    currentPerson = Person();
    contacts = contacts;
  }

  void deleteContact(Person person) {
    contacts.remove(person);
    contacts = contacts;
  }
}
