bool intToBool(int value) {
  if (value != 0 && value != 1) {
    throw ArgumentError(
      'Tried to convert from int to bool, but int was no 0 or 1 and was $value',
    );
  }
  return value == 1;
}

int boolToInt(bool value) {
  return value ? 1 : 0;
}
