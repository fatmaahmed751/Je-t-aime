import 'package:flutter/material.dart';
import 'package:je_t_aime/Utilities/strings.dart';
import 'package:je_t_aime/core/Language/locales.dart';

class Validate {

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return Strings.passwordRequired.tr;
    }

    if (password.length < 8) {
      return Strings.lengthPassword.tr;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigit = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase) {
      return Strings.upperCase.tr;
    }
    if (!hasLowercase) {
      return Strings.lowerCase.tr;
    }
    if (!hasDigit) {
      return Strings.oneNumber.tr ;
    }
    if (!hasSpecialChar) {
      return Strings.specialCharacter.tr;
    }

    return null; // Password is valid
  }
  static String?  validatePhone(String? phone) {
    var phoneRegExp = RegExp(r'^(0[0-9]{10})$');
    var textIsArabic = RegExp(r'^[\0621-\064A0-9 ]+$');
    if (phone!.trim().isEmpty) {
      return Strings.validPhone.tr;
    }  else if(!textIsArabic.hasMatch(phone)){
      return Strings.phoneError.tr;
    } else if (!phoneRegExp.hasMatch(phone)) {
      return Strings.phoneError.tr;
    }
    return null;
  }
  // static String? validatePhone(String? phone) {
  //   if (phone!.trim().isEmpty) {
  //     return Strings.validPhone.tr;
  //   } else if (phone.trim().length > 11 || phone.trim().length < 8) {
  //     return Strings.phoneError.tr;
  //   }
  //   return null;
  // }
  static String? validateConfPassword(
      {required String newPassword, required String confPassword}) {
    if(confPassword.isEmpty){
      return Strings.confirmPassword.tr;
    }
    else if (newPassword.characters == confPassword.characters) {
      return null;
    } else {
      return Strings.confirmPasswordNotMatch.tr;
    }
  }

  static String? validateNormalAddress(String? text) {
    if (text?.isEmpty ?? true) return Strings.validAddress.tr;
    return null;
  }
  static String? validateNormalString(String? text) {
    if (text == null || text.isEmpty) {
      return Strings.notEmptyField.tr;
    }
    return null;
  }

  static String? validateNormalNumber(String? text) {
    if (text?.isEmpty ?? true) {
      return "Please enter a number";
    }
    if (num.tryParse(text!) == null) {
      return "Please enter a valid number";
    }
    return null;
  }
  static String? validateNormalFilterNumber(String? text) {
    // if (text?.isEmpty ?? true) {
    //   return "Please enter a number";
    // }
    if (num.tryParse(text!) == null) {
      return "Please enter a valid number";
    }
    return null;
  }
  static String? validateFilterNumber(String? number, String? startNumber) {
    print("nummm: $number, startttt: $startNumber");

    // Check if the number is empty
    if (number == null || number.trim().isEmpty) {
      return null;  // Return null if the number is empty, as per your requirements
    }

    // Ensure both number and startNumber are valid integers
    int? parsedNumber = int.tryParse(number);
    int? parsedStartNumber = startNumber != null ? int.tryParse(startNumber) : null;

    // Check if parsing failed for number or if startNumber is invalid
    if (parsedNumber == null) {
      return "Please enter a valid number";
    } else if (parsedStartNumber != null && parsedNumber == parsedStartNumber) {
      return Strings.filterNumError.tr;  // Return error if numbers match
    }

    // Ensure parsedStartNumber is valid and check if parsedNumber is less than parsedStartNumber
    if (parsedStartNumber != null && parsedNumber < parsedStartNumber) {
      return Strings.filterNumEnd.tr;  // Return error if parsedNumber is less than parsedStartNumber
    }

    // If all conditions are met, return null (indicating no error)
    return null;
  }


  // static String? validateFilterNumber(String? number,String? startNumber) {
  //   if (number!.trim().isEmpty) {
  //     return null;
  //   } else if(startNumber!=null&&(int.parse(number)==int.parse(startNumber??''))){
  //     return Strings.filterNumError.tr;
  //   }
  //   if (num.tryParse(number) == null) {
  //     return "Please enter a valid number";
  //   }
  //   return null;
  // }
  static String? validateDropDown(dynamic value) {
    return value == null ? "Select one" : null;
  }



  static String? validatePhoneOptional(String? phone) {
    if (phone!.trim().isEmpty) return null;
    //return validatePhone(phone);
  }

  static validateFullName(String? name) {
    if (name == null) return Strings.validName.tr;
    if (name.trim().isEmpty) {
      return Strings.validName.tr;
    }
    return null;
  }

  static validateEmail(String? email) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)$");
    if (email!.trim().isEmpty) {
      return Strings.validEmail.tr;
    } else if (!emailRegExp.hasMatch(email)) {
      return Strings.emailError.tr;
    }
    return null;
  }

  static validateFlat(String? flat) {
    if (flat!.trim().isEmpty) {
      return Strings.flatValid.tr;
    }
    return null;
  }
}
