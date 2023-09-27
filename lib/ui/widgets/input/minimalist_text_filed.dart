import 'package:flutter/material.dart';

class MinimalistTextField extends StatefulWidget {
  const MinimalistTextField({
    super.key,
    required this.lable,
    this.controller,
    this.isPassword = false,
    this.onChanged,
    this.onlyNumbers = false,
  });

  final String lable;
  final TextEditingController? controller;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final bool onlyNumbers;

  @override
  State<MinimalistTextField> createState() => _MinimalistTextFieldState();
}

class _MinimalistTextFieldState extends State<MinimalistTextField> {
  bool _obscureText = true;
  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 15,
      ),
      child: SizedBox(
        width: size.width > 750 ? size.width / 3 : null ,
        child: TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          keyboardType: widget.onlyNumbers ? TextInputType.number : null,
          decoration: InputDecoration(
            labelText: widget.lable,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.purple, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.purple),
            ),
            labelStyle: TextStyle(
              fontSize: 15.0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: _obscureText
                          ? Colors.purple
                          : const Color.fromARGB(197, 126, 67, 136),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.transparent,
            counterStyle: const TextStyle(
              color: Colors.red,
            ),
            hintStyle: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
