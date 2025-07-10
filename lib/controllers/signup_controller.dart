import 'package:get/get.dart';

class SignupController extends GetxController {
  // Fields
  var fullName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  // Error messages
  var fullNameError = ''.obs;
  var emailError = ''.obs;
  var phoneError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  // Validators
  void validateFullName(String value) {
    fullName.value = value;
    fullNameError.value =
    value.isEmpty ? 'Full name is required' : '';
  }

  void validateEmail(String value) {
    email.value = value;
    if (value.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!value.contains('@') || !value.contains('.')) {
      emailError.value = 'Invalid email';
    } else {
      emailError.value = '';
    }
  }

  void validatePhone(String value) {
    phone.value = value;
    if (value.isEmpty) {
      phoneError.value = 'Phone is required';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      phoneError.value = 'Only numbers allowed';
    } else if (value.length < 11) {
      phoneError.value = 'Minimum 11 digits';
    } else {
      phoneError.value = '';
    }
  }

  void validatePassword(String value) {
    password.value = value;
    if (value.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (value.length < 6) {
      passwordError.value = 'Min 6 characters';
    } else {
      passwordError.value = '';
    }
  }

  void validateConfirmPassword(String value) {
    confirmPassword.value = value;
    if (value.isEmpty) {
      confirmPasswordError.value = 'Confirm your password';
    } else if (value != password.value) {
      confirmPasswordError.value = 'Passwords do not match';
    } else {
      confirmPasswordError.value = '';
    }
  }

  // Check if the form is valid
  bool get isFormValid =>
      fullNameError.value.isEmpty &&
          emailError.value.isEmpty &&
          phoneError.value.isEmpty &&
          passwordError.value.isEmpty &&
          confirmPasswordError.value.isEmpty &&
          fullName.value.isNotEmpty &&
          email.value.isNotEmpty &&
          phone.value.isNotEmpty &&
          password.value.isNotEmpty &&
          confirmPassword.value.isNotEmpty;
}
