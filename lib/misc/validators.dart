typedef AppValidatorFunc = String? Function();

String? combineValidators(List<AppValidatorFunc> validators) {
  for (var validator in validators) {
    final errorText = validator();
    if (errorText != null) return errorText;
  }
  return null;
}
