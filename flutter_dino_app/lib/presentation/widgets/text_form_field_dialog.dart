import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TextFormFieldDialog extends StatefulWidget {
  final String initialValue;
  final String label;
  final bool canBeEmpty;
  final bool isEmail;
  String value = "";

  TextFormFieldDialog({
    Key? key,
    required this.initialValue,
    required this.label,
    this.canBeEmpty = false,
    this.isEmail = false,
  }) : super(key: key) {
    value = initialValue;
  }

  @override
  State<TextFormFieldDialog> createState() => _TextFormFieldDialogState();
}

class _TextFormFieldDialogState extends State<TextFormFieldDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: PomodoroTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: PomodoroTheme.white,
          width: 2,
        ),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          style: PomodoroTheme.textLarge,
          initialValue: widget.initialValue,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: PomodoroTheme.textLarge,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              if (widget.canBeEmpty) {
                return null;
              } else {
                return "Ce champ ne peut pas être vide";
              }
            } else if (widget.isEmail && !value.contains("@")) {
              return "Veuillez entrer une adresse email valide";
            } else {
              return null;
            }
          },
          onChanged: (value) {
            setState(() {
              widget.value = value;
            });
          },
        ),
      ),
      actionsPadding: const EdgeInsets.all(10),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: PomodoroTheme.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Annuler",
            style: PomodoroTheme.textBold,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: PomodoroTheme.green,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(widget.value);
            }
          },
          child: const Text(
            "Confirmer",
            style: PomodoroTheme.textBold,
          ),
        ),
      ],
    );
  }
}
