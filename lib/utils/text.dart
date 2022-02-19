String pluralize(String word, {int? count}) {
  if (count != null && count == 1) {
    return word;
  }
  return word + 's';
}

String capitalize(String word) {
  if (word.length < 2) {
    return word.toUpperCase();
  }
  return word[0].toUpperCase() + word.substring(1);
}
