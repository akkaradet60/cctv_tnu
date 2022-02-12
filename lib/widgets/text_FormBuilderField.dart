import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderFieldText extends StatelessWidget {
  final String name;
  final String labelText;
  final IconData icon;
  final String initialValue;
  FormBuilderFieldText({
    Key? key,
    required this.name,
    required this.labelText,
    required this.icon,
    required this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(2, 2),
                blurRadius: 7,
                spreadRadius: 1.0),
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(2, 4),
                blurRadius: 7.0,
                spreadRadius: 1.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: FormBuilderTextField(
            initialValue: initialValue,
            name: name,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              suffixIcon: Icon(icon),
              labelText: labelText,
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}
