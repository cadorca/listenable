// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// ListenerGenerator
// **************************************************************************

mixin _Counter$Listenable on _Counter {
  // Fields
  _CounterChangeProperty<int> __counterPropertyNotifier;

  set _counter($newValue) {
    if (_counter != $newValue) {
      super._counter = $newValue;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      if (__counterPropertyNotifier != null) {
        __counterPropertyNotifier.notifyListeners();
      }

      if (_changeNotifier != null) {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        _changeNotifier.notifyListeners();
      }
    }
  }

  ValueListenable<int> get counterListenable {
    if (__counterPropertyNotifier == null) {
      __counterPropertyNotifier = _CounterChangeProperty(() => super._counter);
    }
    return __counterPropertyNotifier;
  }

  _CounterChangeProperty<Counter> _changeNotifier;

  ValueListenable<Counter> get listenable {
    if (_changeNotifier == null) {
      _changeNotifier = _CounterChangeProperty<Counter>(() => this);
    }
    return _changeNotifier;
  }

  void dispose() {
    __counterPropertyNotifier.dispose();
  }

  void notifyListeners() {}
}

class _CounterChangeProperty<T> extends ChangeNotifier
    implements ValueListenable<T> {
  final T Function() valueAccessor;
  _CounterChangeProperty(this.valueAccessor);
  @override
  T get value => valueAccessor();
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
