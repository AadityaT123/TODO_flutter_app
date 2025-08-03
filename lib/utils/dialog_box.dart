import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCancle;
  final VoidCallback onSave;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onCancle,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.black), // Input text color
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add New Task",
                hintStyle: TextStyle(color: Colors.black), // Hint text color
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancle,
                  child: const Text(
                    "cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: onSave,
                  child: const Text(
                    "save",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
