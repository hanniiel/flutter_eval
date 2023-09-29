import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    Key? key,
    required this.hint,
    required this.title,
    this.onValidate,
    this.onChanged,
    this.textType = TextInputType.text,
    this.initValue,
    this.readOnly = false,
  }) : super(key: key);

  final String? initValue;
  final String hint, title;
  final bool readOnly;
  final String? Function(String?)? onValidate;
  final TextInputType textType;
  final Function(String?)? onChanged;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  double percentageVal = 0;
  bool visiblePassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: widget.readOnly,
          initialValue: widget.initValue,
          maxLines: widget.textType == TextInputType.multiline ? 3 : 1,
          onChanged: (val) {
            widget.onChanged?.call(val);
          },
          inputFormatters: [
            //Allow only numbers to be typed
            if (widget.textType == TextInputType.number)
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(?:-\d+)?$')),
          ],
          keyboardType: widget.textType,
          obscureText: widget.textType == TextInputType.visiblePassword &&
              !visiblePassword,
          obscuringCharacter: '*',
          validator: (val) => widget.onValidate?.call(val),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hint,
            suffix: widget.textType == TextInputType.visiblePassword
                ? InkWell(
                    onTap: () => setState(() {
                      visiblePassword = !visiblePassword;
                    }),
                    child: Icon(
                      visiblePassword
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_outlined,
                    ),
                  )
                : null,
            hintStyle: const TextStyle(color: Color(0xFF455A64)),
            border: widget.readOnly
                ? InputBorder.none
                : const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Color(0xFF78909C),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
