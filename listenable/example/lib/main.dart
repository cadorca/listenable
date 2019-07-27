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
