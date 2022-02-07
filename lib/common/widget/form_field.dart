import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const InputDecoration defaultInputDecoration = InputDecoration();
const Icon defaultPickerIcon = Icon(Icons.arrow_drop_down);

abstract class CustomFormField<T> extends FormField<T> {
  final CustomFormFieldController<T>? controller;

  CustomFormField({
    Key? key,
    required FormFieldBuilder<T> builder,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    this.controller,
    T? initialValue,
    FormFieldValidator<T>? validator,
    FormFieldSetter<T>? onSaved,
  }) : super(
          initialValue: controller != null ? controller.value : initialValue,
          builder: builder,
          validator: validator,
          onSaved: onSaved,
          autovalidateMode: autoValidateMode,
          enabled: enabled,
          key: key,
        );

  @override
  FormFieldState<T> createState() => CustomFormFieldState<T>();
}

class CustomFormFieldState<T> extends FormFieldState<T> {
  late final VoidCallback _listener;
  late final CustomFormFieldController<T>? _controllerField;

  @override
  CustomFormField<T> get widget => super.widget as CustomFormField<T>;

  @override
  void initState() {
    super.initState();
    _controllerField = widget.controller;
    _listener = () {
      final newValue = _controllerField?.value;
      if (newValue != null && value != newValue) didChange(newValue);
    };
    _controllerField?.textListener(didChange);
    _controllerField?.addListener(_listener);
  }

  @override
  void didUpdateWidget(CustomFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controllerField != oldWidget.controller) {
      oldWidget.controller?.removeListener(_listener);
      final controller = this._controllerField;
      if (controller != null) {
        controller.addListener(_listener);
        setValue(controller.value);
      }
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      final initialValue = widget.initialValue;
      if (initialValue != null) _controllerField?.value = initialValue;
    });
  }

  @override
  void didChange(T? value) {
    super.didChange(value);
    final valueResult = value;
    if (valueResult != null && _controllerField?.value != value) {
      _controllerField?.value = valueResult;
    }

    /// check mounted to prevent memory leak when setState after dispose
    if (mounted && this.value != value) {
      super.didChange(value);
    }
  }

  @override
  void dispose() {
    _controllerField?.removeListener(_listener);
    super.dispose();
  }
}

abstract class CustomFormFieldController<T> extends ChangeNotifier
    implements ValueListenable<T> {
  final TextEditingController textController = TextEditingController();

  T _value;

  CustomFormFieldController(this._value) {
    final value = fromValue(_value);
    textController.text = value;
  }

  void textListener(void Function(T value) didChange) {
    textController.addListener(() {
      final newValue = toValue(textController.text);
      if (newValue != null && _value != newValue) {
        didChange(newValue);
      }
    });
  }

  String fromValue(T value);

  T toValue(String text);

  @override
  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    final text = fromValue(_value);
    if (text != textController.text) textController.text = text;
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
