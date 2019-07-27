import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'phonebook_models.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Listenable Phonebook Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Phonebook"),
          ),
          body: Center(
            child: SafeArea(
              child: DirectoryWidget(),
            ),
          ),
        ));
  }
}

class DirectoryWidget extends StatefulWidget {
  @override
  _DirectoryWidgetState createState() => _DirectoryWidgetState();
}

class _DirectoryWidgetState extends State<DirectoryWidget> {
  final controller = PhoneBookController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DirectoryForm(controller),
        ),
        Expanded(
          child: ContactListWidget(controller),
        ),
      ],
    );
  }
}

class ContactListWidget extends StatelessWidget {
  final PhoneBookController controller;

  ContactListWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ValueListenableBuilder<List<Person>>(
          valueListenable: controller.contactsListenable,
          builder: (context, snapshot, _) {
            return ListView.builder(
              itemCount: controller.contacts.length,
              itemBuilder: (BuildContext context, int index) {
                final contact = snapshot[index];
                return Dismissible(
                  key: ValueKey(contact),
                  onDismissed: (direction) {
                    controller.deleteContact(snapshot[index]);
                  },
                  child: ContactInformation(controller, contact),
                );
              },
            );
          }),
    );
  }
}

class ContactInformation extends StatelessWidget {
  final PhoneBookController controller;
  final Person contact;

  ContactInformation(this.controller, this.contact);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        key: ValueKey(contact),
        title: ValueListenableBuilder<String>(
          valueListenable: contact.nameListenable,
          builder: (context, name, _) => Text(name),
        ),
        subtitle: ValueListenableBuilder<String>(
          valueListenable: contact.cellPhoneListenable,
          builder: (context, phone, _) => Text(phone),
        ),
        leading: ValueListenableBuilder<bool>(
          valueListenable: contact.favoriteListenable,
          builder: (context, favorite, _) => IconButton(
            icon: Icon(favorite ? Icons.star : Icons.star_border),
            tooltip: 'Mark contact as favorite',
            onPressed: () {
              contact.favorite = !contact.favorite;
            },
          ),
        ),
        trailing: ValueListenableBuilder<double>(
            valueListenable: contact.ageListenable,
            builder: (context, age, _) {
              return Text('$age');
            }),
        onTap: () {
          controller.currentPerson = contact;
        },
      ),
    );
  }
}

class DirectoryForm extends StatelessWidget {
  final PhoneBookController controller;
  final FocusNode _focusNode = FocusNode();

  DirectoryForm(this.controller);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Person>(
      valueListenable: controller.currentPersonListenable,
      builder: (context, person, _) {
        print('Rebuilding Contact List');
        final contactList = Column(
          children: <Widget>[
            TextField(
              focusNode: _focusNode,
              controller: TextEditingController(text: person.name),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              onChanged: (nValue) {
                person.name = nValue;
              },
            ),
            Container(
              height: 12,
            ),
            TextField(
              controller: TextEditingController(text: person.cellPhone),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CellPhone',
              ),
              keyboardType: TextInputType.number,
              onChanged: (nValue) {
                person.cellPhone = nValue;
              },
            ),
            ValueListenableBuilder<double>(
              valueListenable: person.ageListenable,
              builder: (context, ageSnapshot, _) {
                return new AgeSlider(person, ageSnapshot);
              },
            ),
            Container(
              height: 1.5,
              width: MediaQuery.of(context).size.width - 12,
              color: Colors.black26,
            ),
            Container(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text('New Contact'),
                  onPressed: () {
                    controller.newContact();
                  },
                ),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () {
                    controller.addContact();
                  },
                )
              ],
            )
          ],
        );
        FocusScope.of(context).requestFocus(_focusNode);
        return contactList;
      },
    );
  }
}

class AgeSlider extends StatelessWidget {
  final Person person;
  final double currentValue;

  const AgeSlider(this.person, this.currentValue, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: currentValue,
      min: 0,
      max: 100,
      divisions: 10,
      label: 'Age ${currentValue.toInt()}',
      onChanged: (nValue) {
        person.age = nValue.round().toDouble();
      },
    );
  }
}
