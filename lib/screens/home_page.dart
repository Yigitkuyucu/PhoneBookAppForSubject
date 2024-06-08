import 'package:flutter/material.dart';
import 'package:phone_book_application/models/person.dart';
import 'blocked_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Person> persons = [
    Person(firstName: "Ahmet", lastName: "Varli", phoneNumber: "05436541216", email: "ahmetvarli@gmail.com"),
    Person(firstName: "Mehmet", lastName: "Caglayan", phoneNumber: "05058425784", email: "mehmet_caglayan@outlook.com"),
  ];

  void addPerson(String firstName, String lastName, String phoneNumber, String email) {
    setState(() {
      persons.add(Person(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: email,
      ));
    });
  }

  void deletePerson(int index) {
    setState(() {
      persons.removeAt(index);
    });
  }

  void blockPerson(int index) {
    setState(() {
      persons[index].personStatus = true;
    });
  }

  void unblockPerson(int index) {
    setState(() {
      persons[index].personStatus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Phonebook'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Blocked') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlockedPage(persons: persons, unblockPerson: unblockPerson)),
                );
              }
            },
            itemBuilder: (BuildContext context) => {'Blocked'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          if (persons[index].personStatus) return Container();
          return ListTile(
            title: Text('${persons[index].firstName} ${persons[index].lastName}'),
            subtitle: Text(persons[index].phoneNumber),
            leading: const Icon(Icons.account_circle),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage(person: persons[index], updatePerson: (updatedPerson) {
                      setState(() {
                        persons[index] = updatedPerson;
                      });
                    })),
                  );
                } else if (value == 'Block') {
                  blockPerson(index);
                } else if (value == 'Delete') {
                  deletePerson(index);
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Profile', 'Block', 'Delete'}.map((String choice) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String firstName = '';
              String lastName = '';
              String phoneNumber = '';
              String email = '';
              return AlertDialog(
                title: const Text('Add Person'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'First Name'),
                      onChanged: (value) {
                        firstName = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      onChanged: (value) {
                        lastName = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      addPerson(firstName, lastName, phoneNumber, email);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
