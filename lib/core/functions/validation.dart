import '../extensions/validation_extension.dart';

enum ValidationType { name, password, phone, email }

String? validInput(String value, int min, int max, ValidationType type) {
  if (value.isEmpty || value.isNull) return "can't be Empty";

  if (value.length < min) return "can't be less than $min";

  if (value.length > max) return "can't be larger than $max";

  if (type == ValidationType.name && value.isValidName) {
    return "not valid username";
  }

  if (type == ValidationType.email && value.isValidEmail) {
    return "not valid email";
  }

  if (type == ValidationType.phone && value.isValidPhone) {
    return "not valid phone";
  }

  if (type == ValidationType.password && value.isValidPassword) {
    return "not valid password";
  }

  return null;
}
