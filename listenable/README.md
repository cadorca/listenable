# Listenable

Listenable help you to manage Flutter widgets and state synchronization by leveraging the [ValueListenable] class.
You will annotate you models and it will generate the required code for your models to be listenable by a ListenableBuilder widget.

## Usage

A simple usage example:

### 1. Add dependencies

```yaml
dependencies:
  listenable: ^0.3.0

dev_dependencies:
  listenable_generator: ^0.3.0  
  build_runner: ^1.1.0
```

### 2. Annotate your code and add the generated part to your file
```dart
import 'package:listenable/listenable.dart';

part 'main.g.dart';

class Counter = _Counter with _Counter$Listenable;

@ListenableModel()
abstract class _Counter {
  @ListenableProperty()
  int _counter = 0;

  void increment() {
    _counter++;
  }
}
```

### 3. Run the generation source command
```bash
 flutter pub run build_runner build
```

### 4. Listen for changes in your widgets

Rebuild you widgets using the flutter existing widgets, *you don't need any additional library*

```dart
import 'package:flutter/widgets.dart';

class CounterWidget extends StatelessWidget {
  final Counter _counter;
  CounterWidget(this._counter);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _counter.counterListenable,
      builder: (context, count, _) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Current Value for counter :',style: TextStyle(fontSize: 23),
          ),
          Text(
            '$count',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
```

### 5. Run the generation source command continuously (optional)
```bash
 flutter pub run build_runner watch
```

### A complete example
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listenable/listenable.dart';

part 'main.g.dart';

class Counter = _Counter with _Counter$Listenable;

@ListenableModel()
abstract class _Counter {
  @ListenableProperty()
  int _counter = 0;

  void increment() {
    _counter++;
  }
}

class CounterWidget extends StatelessWidget {
  final Counter _counter;

  CounterWidget(this._counter);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _counter.counterListenable,
      builder: (context, count, _) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Current Value for counter :',
            style: TextStyle(fontSize: 23),
          ),
          Text(
            '$count',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final _counter = Counter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage('Flutter Demo Home Page', _counter),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Counter _counter;
  final String title;

  MyHomePage(this.title, this._counter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: CounterWidget(_counter),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() => runApp(MyApp());
```


## Examples
[example]: https://github.com/cadorca/listenable/listenable/example

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/cadorca/listenable/issues
