import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/constants/content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../scroll_controller_inherited.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // First, attempt to save the submission to Google Sheets via a web endpoint.
      // Configure SHEET_ENDPOINT: deploy a Google Apps Script as a web app that receives POST
      // requests and appends rows to your Sheet, then paste its URL below.
    const sheetEndpoint = '<YOUR_GOOGLE_SHEETS_WEBAPP_URL_HERE>'; // <-- set this to your Apps Script URL

      final data = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'message': _messageController.text.trim(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Attempt to post to the sheet endpoint. If the user hasn't configured it, the
      // request will fail; in that case we fall back to opening the mail client.
      Future<void> performSend() async {
        var saved = false;
  if (sheetEndpoint.isNotEmpty && !sheetEndpoint.contains('<YOUR_')) {
          try {
            final resp = await http.post(
              Uri.parse(sheetEndpoint),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(data),
            ).timeout(const Duration(seconds: 8));
            // Note: some Apps Script endpoints may return 200 with text; treat 200 as success
            if (resp.statusCode >= 200 && resp.statusCode < 300) {
              saved = true;
            }
          } catch (_) {
            saved = false;
          }
        }

        // Always open the mail composer as a fallback/secondary action
        final mailUri = Uri(
          scheme: 'mailto',
          path: 'shoroardi.sumon@gmail.com',
          queryParameters: {
            'subject': 'Contact from Portfolio: ${_nameController.text}',
            'body': '${_messageController.text}\n\nFrom: ${_nameController.text} (${_emailController.text})',
          },
        );

        if (await canLaunchUrl(mailUri)) {
          await launchUrl(mailUri);
        }

        _clearForm();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(saved ? 'Message saved & mail composer opened.' : 'Message not saved to Sheets; mail composer opened.')),
          );
        }
      }

      performSend();
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    final scrollController = ScrollControllerInherited.of(context)!;

    return AutoScrollTag(
      key: const ValueKey('contact'),
      controller: scrollController,
      index: 6,
      highlightColor: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.all(isMobile ? 20.0 : 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: 'Contact Section Title',
                  child: Text(
                    contactTitle,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(_nameController, nameLabel, Icons.person, (value) => (value == null || value.isEmpty) ? 'Please enter your name' : null),
                      const SizedBox(height: 10),
                      _buildTextField(_emailController, emailLabel, Icons.email, (value) => (value == null || value.isEmpty || !value.contains('@')) ? 'Please enter a valid email' : null),
                      const SizedBox(height: 10),
                      _buildTextField(
                        _messageController,
                        messageLabel,
                        Icons.message,
                        (value) => (value == null || value.isEmpty) ? 'Please enter a message' : null,
                        maxLines: isMobile ? 4 : 5,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _submitForm,
                          icon: const Icon(Icons.send),
                          label: const Text(sendMessageLabel),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ).animate().slideY(begin: 0.3, end: 0.0, duration: const Duration(milliseconds: 800), curve: Curves.easeOut);
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    String? Function(String?)? validator, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}