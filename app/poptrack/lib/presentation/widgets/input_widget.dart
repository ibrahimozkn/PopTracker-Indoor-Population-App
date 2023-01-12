import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final ValueChanged<String> onChanged;
  final IconData icon;
  final TextInputAction action;
  final Function onTap;
  final bool readOnly;
  final TextInputType inputType;
  final bool obsecure;
  const InputWidget({Key? key, this.obsecure = false,this.inputType = TextInputType.text, required this.controller, required this.label, required this.onChanged, required this.icon, required this.action, required this.onTap, this.readOnly = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 25, right: 25),
      child: TextFormField(
        obscureText: obsecure,
        keyboardType: inputType,
        readOnly: readOnly,
        textInputAction: action,
        controller: controller,
        onTap: () => onTap,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(
            icon,
          ),
        ),
      ),
    );
  }
}