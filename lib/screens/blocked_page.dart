import 'package:flutter/material.dart';
import 'package:phone_book_application/models/person.dart';

class BlockedPage extends StatelessWidget {
  final List<Person> persons;
  final Function(int) unblockPerson;

  const BlockedPage({super.key, required this.persons, required this.unblockPerson});

  @override
  Widget build(BuildContext context) {
    List<Person> blockedPersons = persons.where((person) => person.personStatus).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Persons'),
      ),
      body: ListView.builder(
        itemCount: blockedPersons.length,
        itemBuilder: (context, index) {
          int originalIndex = persons.indexOf(blockedPersons[index]);
          return ListTile(
            title: Text('${blockedPersons[index].firstName} ${blockedPersons[index].lastName}'),
            subtitle: Text(blockedPersons[index].phoneNumber),
            leading: const Icon(Icons.account_circle),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Unblock') {
                  unblockPerson(originalIndex);
                  Navigator.pop(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Unblock'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          );
        },
      ),
    );
  }
}
