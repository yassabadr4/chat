import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
   CustomFormTextField({this.onChanged,this.hintText,this.labelText,this.obScure = false});
 String? hintText;
 String? labelText;
 Function(String)? onChanged;
 bool? obScure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obScure!,
      validator: (String? data)
      {
        if(data!.isEmpty)
        {
          return "field is required";
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
        ),
      ),
    );
  }
}
