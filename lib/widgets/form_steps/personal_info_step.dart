import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';

class PersonalInfoStep extends ConsumerWidget {
  const PersonalInfoStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final pi = cv.personalInfo;
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo picker
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _pickPhoto(context, ref),
                  child: Container(
                    width: 90,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: pi.photoBytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.memory(pi.photoBytes!, fit: BoxFit.cover),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_outlined, color: Colors.grey.shade500, size: 28),
                              const SizedBox(height: 4),
                              Text(l.t('uploadPhoto'), style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                            ],
                          ),
                  ),
                ),
                if (pi.photoBase64 != null) ...[
                  const SizedBox(height: 6),
                  TextButton.icon(
                    onPressed: () => notifier.updatePhoto(null),
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: Text(l.t('removePhoto'), style: const TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Name row
          Row(
            children: [
              Expanded(child: _field(label: l.t('firstName'), value: pi.firstName, onChanged: notifier.updateFirstName)),
              const SizedBox(width: 10),
              Expanded(child: _field(label: l.t('lastName'), value: pi.lastName, onChanged: notifier.updateLastName)),
            ],
          ),
          const SizedBox(height: 12),
          _field(label: l.t('email'), value: pi.email, onChanged: notifier.updateEmail, keyboard: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _field(label: l.t('phone'), value: pi.phone, onChanged: notifier.updatePhone, keyboard: TextInputType.phone),
          const SizedBox(height: 12),
          _field(label: l.t('address'), value: pi.address, onChanged: notifier.updateAddress),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _field(label: l.t('birthDate'), value: pi.birthDate, onChanged: notifier.updateBirthDate)),
              const SizedBox(width: 10),
              Expanded(child: _field(label: l.t('nationality'), value: pi.nationality, onChanged: notifier.updateNationality)),
            ],
          ),
          const SizedBox(height: 12),
          _field(label: l.t('linkedin'), value: pi.linkedin, onChanged: notifier.updateLinkedin, keyboard: TextInputType.url),
          const SizedBox(height: 12),
          _field(label: l.t('website'), value: pi.website, onChanged: notifier.updateWebsite, keyboard: TextInputType.url),
        ],
      ),
    );
  }

  Widget _field({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    TextInputType keyboard = TextInputType.text,
  }) {
    return _ControlledTextField(label: label, initialValue: value, onChanged: onChanged, keyboardType: keyboard);
  }

  Future<void> _pickPhoto(BuildContext context, WidgetRef ref) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Galleria'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Fotocamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    final picker = ImagePicker();
    final file = await picker.pickImage(source: source, maxWidth: 400, maxHeight: 500, imageQuality: 85);
    if (file == null) return;

    final bytes = await file.readAsBytes();
    ref.read(cvProvider.notifier).updatePhoto(base64Encode(bytes));
  }
}

class _ControlledTextField extends StatefulWidget {
  const _ControlledTextField({
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  @override
  State<_ControlledTextField> createState() => _ControlledTextFieldState();
}

class _ControlledTextFieldState extends State<_ControlledTextField> {
  late TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(_ControlledTextField old) {
    super.didUpdateWidget(old);
    if (old.initialValue != widget.initialValue && _ctrl.text != widget.initialValue) {
      _ctrl.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _ctrl,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        isDense: true,
      ),
      style: const TextStyle(fontSize: 14),
      onChanged: widget.onChanged,
    );
  }
}
