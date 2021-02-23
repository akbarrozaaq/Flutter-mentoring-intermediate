import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool obsecureText;
  final Function onSaved;
  final Function validator;
  final Function showPass;
  final Color colorIcon;
  final TextEditingController controller;
  const RoundedPasswordField(
      {Key key,
      this.onChanged,
      this.obsecureText,
      this.onSaved,
      this.validator,
      this.showPass,
      this.colorIcon,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        obscureText: obsecureText,
        onChanged: onChanged,
        cursorColor: Colors.blue,
        controller: controller,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Color(0xFF81F4E1),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            onPressed: showPass,
            color: colorIcon,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
