class FormValidations {
  FormValidations._internal();

  static final FormValidations _instance = FormValidations._internal();

  static FormValidations get instance => _instance;

  //put validation here
  String? requiredField(String? value, {String? errorText}) {
    if (value!.isEmpty) {
      return errorText;
    }
    return null;
  }
}
