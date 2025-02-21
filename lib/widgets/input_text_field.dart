import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool automaticallyDisposeController;
  final String text;
  final double width;
  final int maxLines;
  final bool readOnly;
  final bool requestFocus;
  final String label;
  final String hint;
  final String suffix;
  final bool required;
  final bool isPasswd;
  final TextInputType keyboardType;
  final VoidCallback? onTap;

  const InputTextField({
    Key? key,
    required this.controller,
    this.inputFormatters,
    this.automaticallyDisposeController = true,
    this.text = '',
    this.width = double.infinity,
    this.maxLines = 1,
    this.readOnly = false,
    this.requestFocus = false,
    this.label = '',
    this.hint = '',
    this.suffix = '',
    this.required = false,
    this.isPasswd = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final inputTextFocusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    if (widget.requestFocus) inputTextFocusNode.requestFocus();
    inputTextFocusNode.addListener(() {
      setState(() {
        _isFocused = inputTextFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.automaticallyDisposeController) widget.controller.dispose();
    inputTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: widget.width,
      height: 45,
      child: TextFormField(
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        readOnly: widget.readOnly,
        focusNode: inputTextFocusNode,
        obscureText: widget.isPasswd,
        keyboardType: widget.keyboardType,
        onTap: widget.onTap,
        validator: (text) {
          if (widget.required && (text == null || text.isEmpty)) {
            return 'Campo obrigatório';
          }
          return null;
        },
        style: textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        cursorColor: colorScheme.inverseSurface,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.error),
          ),
          label: widget.label.isNotEmpty
              ? Text(
                  widget.label,
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _isFocused ? colorScheme.primary : colorScheme.inverseSurface,
                  ),
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: widget.hint.isNotEmpty ? widget.hint : null,
          hintStyle: textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.inverseSurface,
          ),
          errorStyle: textTheme.bodySmall!.copyWith(
            color: colorScheme.error,
          ),
          suffix: widget.suffix.isNotEmpty
              ? Text(widget.suffix, style: _isFocused ? textTheme.headlineSmall!.copyWith(color: colorScheme.primary) : textTheme.headlineSmall)
              : null,
        ),
      ),
    );
  }
}
