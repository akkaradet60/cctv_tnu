import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../page/global/style/global.dart';

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
            10,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(2, 4),
                blurRadius: 7.0,
                spreadRadius: 1.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              child: FormBuilderTextField(
                name: name,
                initialValue: initialValue,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  helperText: labelText,
                  suffixIcon: Icon(icon),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ThemeBc.black),
                  ),
                  // labelText: 'Email',
                  hintText: labelText,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
