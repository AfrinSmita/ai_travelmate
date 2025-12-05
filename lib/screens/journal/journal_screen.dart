import 'package:flutter/material.dart';
import '../../models/journal_entry.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final entries = <JournalEntry>[];

  void addEntry() async {
    final titleCtrl = TextEditingController();
    final contentCtrl = TextEditingController();

    final save = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("New Journal Entry"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: contentCtrl, decoration: const InputDecoration(labelText: "Content")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (save == true) {
      setState(() {
        entries.add(JournalEntry(
          titleCtrl.text.trim(),
          contentCtrl.text.trim(),
          DateTime.now(),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip Journal")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: addEntry,
      ),
      body: entries.isEmpty
          ? const Center(child: Text("No travel memories yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: entries.length,
              itemBuilder: (context, i) {
                final e = entries[i];
                return Card(
                  child: ListTile(
                    title: Text(e.title),
                    subtitle: Text(e.content),
                    trailing: Text("${e.date.day}/${e.date.month}"),
                  ),
                );
              },
            ),
    );
  }
}
