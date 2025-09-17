import 'package:crud/riverpod/clss/statenotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cmnvar.dart';

class StateproviderTask extends ConsumerStatefulWidget {
  const StateproviderTask({super.key});

  @override
  ConsumerState<StateproviderTask> createState() => _StateproviderTaskState();
}

class _StateproviderTaskState extends ConsumerState<StateproviderTask> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  void showEditDialog(StateModel user, int index) {
    final nameEditController = TextEditingController(text: user.name);
    final placeEditController = TextEditingController(text: user.place);
    final phoneEditController = TextEditingController(text: user.phone);
    final ageEditController = TextEditingController(text: user.age);
    final qualificationEditController = TextEditingController(text: user.qualification);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Details'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameEditController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: placeEditController,
                decoration: const InputDecoration(labelText: 'Place'),
              ),
              TextField(
                controller: phoneEditController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: ageEditController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: qualificationEditController,
                decoration: const InputDecoration(labelText: 'Qualification'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedUser = StateModel(
                name: nameEditController.text,
                place: placeEditController.text,
                phone: phoneEditController.text,
                age: ageEditController.text,
                qualification: qualificationEditController.text,
              );
              ref.read(listOfData.notifier).updateItem(index, updatedUser);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(listOfData);
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: placeController,
              decoration: const InputDecoration(labelText: "Place"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Age"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: qualificationController,
              decoration: const InputDecoration(labelText: "Qualification"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newUser = StateModel(
                  name: nameController.text,
                  place: placeController.text,
                  age: ageController.text,
                  phone: phoneController.text,
                  qualification: qualificationController.text,
                );
                ref.read(listOfData.notifier).addListItem(newUser);
                nameController.clear();
                placeController.clear();
                phoneController.clear();
                ageController.clear();
                qualificationController.clear();
                print( ref.read(listOfData));
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: users.isEmpty
                  ? const Center(child: Text("No data submitted yet."))
                  : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Place: ${user.place}"),
                          Text("Age: ${user.age}"),
                          Text("Qualification: ${user.qualification}"),
                          Text("Phone: ${user.phone}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showEditDialog(user, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ref.read(listOfData.notifier).removeItem(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
