import 'package:flutter/material.dart';

/// Simple non-translated text field with controlled state
class SimpleTextField extends StatefulWidget {
  const SimpleTextField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.multiline = false,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final bool multiline;
  final TextInputType keyboardType;

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  late TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(SimpleTextField old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value && _ctrl.text != widget.value) {
      _ctrl.text = widget.value;
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
      enabled: widget.enabled,
      maxLines: widget.multiline ? 4 : 1,
      keyboardType: widget.multiline ? TextInputType.multiline : widget.keyboardType,
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

/// Extension to replace item at index in a list
extension ListReplace<T> on List<T> {
  List<T> replaceAt(int index, T item) {
    final copy = [...this];
    copy[index] = item;
    return copy;
  }
}
