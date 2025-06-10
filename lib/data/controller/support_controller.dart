import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SupportMessage {
  final String? text;
  final File? file;
  final DateTime timestamp;
  final bool isUser;

  SupportMessage({
    this.text,
    this.file,
    required this.timestamp,
    required this.isUser,
  });
}

class SupportController extends GetxController {
  var messages = <SupportMessage>[].obs;

  // Persistent input controller used in UI
  final TextEditingController inputController = TextEditingController();

  /// Send a text message
  void sendMessage() {
    final trimmed = inputController.text.trim();
    if (trimmed.isNotEmpty) {
      messages.add(
        SupportMessage(
          text: trimmed,
          timestamp: DateTime.now(),
          isUser: true,
        ),
      );
      inputController.clear();
      _simulateReply("Thanks for your message!");
    }
  }

  /// Send a file with optional message text
  Future<void> sendFileWithMessage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);

      final TextEditingController fileMessageController = TextEditingController();

      final messageText = await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a message (optional)'),
            content: TextField(
              controller: fileMessageController,
              decoration: const InputDecoration(hintText: 'Type your message here'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, fileMessageController.text.trim()),
                child: const Text('Send'),
              ),
            ],
          );
        },
      );

      fileMessageController.dispose();

      messages.add(
        SupportMessage(
          file: file,
          text: (messageText?.isEmpty ?? true) ? null : messageText,
          timestamp: DateTime.now(),
          isUser: true,
        ),
      );

      _simulateReply("Received your file.");
    }
  }

  /// Simulates a response from support team
  void _simulateReply(String replyText) {
    Future.delayed(const Duration(seconds: 1), () {
      messages.add(
        SupportMessage(
          text: replyText,
          timestamp: DateTime.now(),
          isUser: false,
        ),
      );
    });
  }

  /// Optional: clear messages and dispose controller
  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }

  void clearChat() {
    messages.clear();
  }
}
