import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
    return NeumorphicButton(
      style: const NeumorphicStyle(
        shape: NeumorphicShape.flat,
        color: ThemeBc.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              child: FormBuilderTextField(
                name: name,
                initialValue: initialValue,
                maxLines: 1,
                // keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  // labelText: 'Email',
                  hintText: labelText,
                  filled: true,
                  fillColor: ThemeBc.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
