import 'package:flutter/material.dart';
import 'package:phone_book_application/models/person.dart';

class ProfilePage extends StatefulWidget {
  final Person person;
  final Function(Person) updatePerson;

  const ProfilePage({super.key, required this.person, required this.updatePerson});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.person.firstName);
    _lastNameController = TextEditingController(text: widget.person.lastName);
    _phoneNumberController = TextEditingController(text: widget.person.phoneNumber);
    _emailController = TextEditingController(text: widget.person.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _editPerson() {
    setState(() {
      widget.updatePerson(
        Person(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phoneNumber: _phoneNumberController.text,
          email: _emailController.text,
          personStatus: widget.person.personStatus,
        ),
      );
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '${widget.person.firstName} ${widget.person.lastName}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                   'Name: ${widget.person.firstName} ${widget.person.lastName}',
                   style: const TextStyle(fontSize: 16),
                    ),
                  Text(
                    'Phone: ${widget.person.phoneNumber}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Email: ${widget.person.email}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Edit Person'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(labelText: 'First Name'),
                          ),
                          TextField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(labelText: 'Last Name'),
                          ),
                          TextField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(labelText: 'Phone Number'),
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(labelText: 'Email'),
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
                          onPressed: _editPerson,
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
