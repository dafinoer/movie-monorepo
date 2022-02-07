import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'form_field.dart';

class CustomTextFormField extends CustomFormField<String> {
  CustomTextFormField({
    required String label,
    required String hint,
    required TextController controller,
    BuildContext? context,
    bool enabled = true,
    bool mandatory = true,
    bool isObscureText = false,
    bool isEmail = false,
    bool isDigit = false,
    FormFieldValidator<String>? validator,
    double padding = 4,
    TextInputAction? textInputAction,
    Widget? suffixIcon,
    Key? key,
  }) : super(
          key: key,
          controller: controller,
          enabled: enabled,
          builder: (FormFieldState<String> state) {
            return _CustomTextForm(
              label: label,
              controller: controller,
              hint: hint,
              state: state,
              mandatory: mandatory,
              isObscureText: isObscureText,
              suffixIcon: suffixIcon,
              isEmail: isEmail,
              isDigit: isDigit,
              padding: padding,
              textInputAction: textInputAction,
            );
          },
          validator: (picker) {
            final isEmptyPicker = picker == null || picker.isEmpty;
            if (mandatory && isEmptyPicker) return 'this field is required';
            if (validator != null) return validator(picker);
            return null;
          },
        );
}

class _CustomTextForm extends StatefulWidget {
  final double padding;
  final bool mandatory;
  final bool isObscureText;
  final bool isEmail;
  final bool isDigit;
  final FormFieldState<String>? state;
  final TextController? controller;
  final String? hint;
  final String? label;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;

  const _CustomTextForm({
    this.state,
    this.controller,
    this.label,
    this.hint,
    this.padding = 0,
    this.isObscureText = false,
    this.isEmail = false,
    this.mandatory = false,
    this.isDigit = false,
    this.textInputAction,
    this.suffixIcon,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<_CustomTextForm> {
  late final FocusNode _focusNode;
  late final List<TextInputFormatter> _inputFormatter;
  late TextInputType _textInputType;
  String? label;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _inputFormatter = <TextInputFormatter>[];
    _focusNode.addListener(() => setState(() {}));
  }

  bool get _mandatory => widget.mandatory;

  void _setLabel() {
    final fullLabel = StringBuffer();
    final label = widget.label;
    if (label != null) {
      fullLabel.write(label);
      if (_mandatory) fullLabel.write(' *');
      this.label = fullLabel.toString();
    }
    this.label = label;
  }

  @override
  void didChangeDependencies() {
    _setLabel();
    if (widget.isDigit) {
      _inputFormatter.add(FilteringTextInputFormatter.digitsOnly);
      _textInputType = TextInputType.number;
    }
    if (widget.isEmail) {
      _textInputType = TextInputType.emailAddress;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _hint = widget.hint;
    final label = this.label;

    return Padding(
      padding: EdgeInsets.only(bottom: widget.padding, top: widget.padding),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(label, style: TextStyle(fontSize: 12)),
                  SizedBox(height: 3),
                  Stack(
                    children: <Widget>[
                      if (widget.controller?.textController == null ||
                          widget.controller?.textController.text.isEmpty ==
                              true)
                        Positioned(
                            top: label != null
                                ? 17
                                : _focusNode.hasFocus
                                    ? 17
                                    : 9,
                            left: 10,
                            child: SizedBox(
                              width: constraints.maxWidth * 0.9,
                              child: Text(
                                _hint != null ? _hint : 'Fill the field here',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          textInputAction: widget.textInputAction,
                          keyboardType: _textInputType,
                          inputFormatters: _inputFormatter,
                          focusNode: _focusNode,
                          textAlignVertical:
                              label == null ? TextAlignVertical.center : null,
                          controller: widget.controller?.textController,
                          decoration: defaultInputDecoration.copyWith(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              isDense: label == null,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              errorText: widget.state?.errorText,
                              alignLabelWithHint: true,
                              suffixIcon: _focusNode.hasFocus
                                  ? widget.suffixIcon ??
                                      IconButton(
                                        icon: const Icon(Icons.cancel),
                                        onPressed: () {
                                          widget.controller?.textController
                                              .clear();
                                        },
                                      )
                                  : null),
                          obscureText: widget.isObscureText,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TextController extends CustomFormFieldController<String> {
  TextController({required String initialValue}) : super(initialValue);

  @override
  String fromValue(String value) => value;

  @override
  String toValue(String text) => text;
}
