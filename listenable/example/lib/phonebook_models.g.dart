// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phonebook_models.dart';

// **************************************************************************
// ListenerGenerator
// **************************************************************************

mixin _Person$Listenable on _Person {
  // Fields
  _PersonChangeProperty<String> _namePropertyNotifier;

  set name($newValue) {
    if (name != $newValue) {
      super.name = $newValue;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      if (_namePropertyNotifier != null) {
        _namePropertyNotifier.notifyListeners();
      }

      if (_changeNotifier != null) {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        _changeNotifier.notifyListeners();
      }
    }
  }

  ValueListenable<String> get nameListenable {
    if (_namePropertyNotifier == null) {
      _namePropertyNotifier = _PersonChangeProperty(() => super.name);
    }
    return _namePropertyNotifier;
  }

  _PersonChangeProperty<String> _cellPhonePropertyNotifier;

  set cellPhone($newValue) {
    if (cellPhone != $newValue) {
      super.cellPhone = $newValue;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      if (_cellPhonePropertyNotifier != null) {
        _cellPhonePropertyNotifier.notifyListeners();
      }

      if (_changeNotifier != null) {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        _changeNotifier.notifyListeners();
      }
    }
  }

  ValueListenable<String> get cellPhoneListenable {
    if (_cellPhonePropertyNotifier == null) {
      _cellPhonePropertyNotifier = _PersonChangeProperty(() => super.cellPhone);
    }
    return _cellPhonePropertyNotifier;
  }

  _PersonChangeProperty<double> _agePropertyNotifier;

  set age($newValue) {
    if (age != $newValue) {
      super.age = $newValue;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      if (_agePropertyNotifier != null) {
        _agePropertyNotifier.notifyListeners();
      }

      if (_changeNotifier != null) {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        _changeNotifier.notifyListeners();
      }
    }
  }

  ValueListenable<double> get ageListenable {
    if (_agePropertyNotifier == null) {
      _agePropertyNotifier = _PersonChangeProperty(() => super.age);
    }
    return _agePropertyNotifier;
  }

  _PersonChangeProperty<bool> _favoritePropertyNotifier;

  set favorite($newValue) {
    if (favorite != $newValue) {
      super.favorite = $newValue;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      if (_favoritePropertyNotifier != null) {
        _favoritePropertyNotifier.notifyListeners();
      }

      if (_changeNotifier != null) {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        _changeNotifier.notifyListeners();
      }
    }
  }

  ValueListenable<bool> get favoriteListenable {
    if (_favoritePropertyNotifier == null) {
      _favoritePropertyNotifier = _PersonChangeProperty(() => super.favorite);
    }
    return _favoritePropertyNotifier;
  }

  _PersonChangeProperty<Person> _changeNotifier;

  ValueListenable<Person> get listenable {
    if (_changeNotifier == null) {
      _changeNotifier = _PersonChangeProperty<Person>(() => this);
    }
    return _changeNotifier;
  }

  void dispose() {
    _namePropertyNotifier.dispose();
    _cellPhonePropertyNotifier.dispose();
    _agePropertyNotifier.dispose();
    _favoritePropertyNotifier.dispose();
  }

  void notifyListeners() {}
}

class _PersonChangeProperty<T> extends ChangeNotifier
    implements ValueListenable<T> {
  final T Function() valueAccessor;
  _PersonChangeProperty(this.valueAccessor);
  @override
  T get value => valueAccessor();
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

mixin _PhoneBookController$Listenable on _PhoneBookController {
  // Fields
  _PhoneBookControllerChangeProperty<double> _agePropertyNotifier;

  set age($newValue) {
    if (age != $newValue) {
      super.age = $newValue;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      if (_agePropertyNotifier != null) {
        _agePropertyNotifier.notifyListeners();
      }

      if (_changeNotifier != null) {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        _changeNotifier.notifyListeners();
      }
    }
  }

  ValueListenable<double> get ageListenable {
    if (_agePropertyNotifier == null) {
      _agePropertyNotifier =
          _PhoneBookControllerChangeProperty(() => super.age);
    }
    return _agePropertyNotifier;
  }

  _PhoneBookControllerChangeProperty<List<Person>> _contactsPropertyNotifier;

  set contacts($newValue) {
    super.contacts = $newValue;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    if (_contactsPropertyNotifier != null) {
      _contactsPropertyNotifier.notifyListeners();
    }

    if (_changeNotifier != null) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      _changeNotifier.notifyListeners();
    }
  }

  ValueListenable<List<Person>> get contactsListenable {
    if (_contactsPropertyNotifier == null) {
      _contactsPropertyNotifier =
          _PhoneBookControllerChangeProperty(() => super.contacts);
    }
    return _contactsPropertyNotifier;
  }

  _PhoneBookControllerChangeProperty<Person> _currentPersonPropertyNotifier;

  set currentPerson($newValue) {
    if (currentPerson != $newValue) {
      super.currentPerson = $newValue;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      if (_currentPersonPropertyNotifier != null) {
        _currentPersonPropertyNotifier.notifyListeners();
      }

      if (_changeNotifier != null) {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        _changeNotifier.notifyListeners();
      }
    }
  }

  ValueListenable<Person> get currentPersonListenable {
    if (_currentPersonPropertyNotifier == null) {
      _currentPersonPropertyNotifier =
          _PhoneBookControllerChangeProperty(() => super.currentPerson);
    }
    return _currentPersonPropertyNotifier;
  }

  _PhoneBookControllerChangeProperty<PhoneBookController> _changeNotifier;

  ValueListenable<PhoneBookController> get listenable {
    if (_changeNotifier == null) {
      _changeNotifier =
          _PhoneBookControllerChangeProperty<PhoneBookController>(() => this);
    }
    return _changeNotifier;
  }

  void dispose() {
    _agePropertyNotifier.dispose();
    _contactsPropertyNotifier.dispose();
    _currentPersonPropertyNotifier.dispose();
  }

  void notifyListeners() {}
}

class _PhoneBookControllerChangeProperty<T> extends ChangeNotifier
    implements ValueListenable<T> {
  final T Function() valueAccessor;
  _PhoneBookControllerChangeProperty(this.valueAccessor);
  @override
  T get value => valueAccessor();
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
