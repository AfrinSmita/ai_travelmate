import 'package:flutter/material.dart';
import '../../services/ai_service.dart';

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  final _cityCtrl = TextEditingController();
  final _daysCtrl = TextEditingController(text: "3");
  final _peopleCtrl = TextEditingController(text: "2");

  String? aiPlan;
  bool loading = false;

  Future<void> _generatePlan() async {
    if (_cityCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter a city")));
      return;
    }

    setState(() => loading = true);

    final result = await AIService.generatePlan(
      _cityCtrl.text.trim(),
      int.tryParse(_daysCtrl.text) ?? 3,
      int.tryParse(_peopleCtrl.text) ?? 2,
    );

    setState(() {
      loading = false;
      aiPlan = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Trip Planner")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cityCtrl,
              decoration: const InputDecoration(
                  labelText: "Destination", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _daysCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Days", border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _peopleCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "People", border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading ? null : _generatePlan,
              child: Text(loading ? "Generating..." : "Generate Plan"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: aiPlan == null
                  ? const Center(child: Text("Your AI plan will appear here"))
                  : SingleChildScrollView(
                      child: Text(aiPlan!, style: const TextStyle(fontSize: 16))),
            ),
          ],
        ),
      ),
    );
  }
}
