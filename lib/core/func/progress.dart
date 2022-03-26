double progress(int done, int total) {
  return total == 0 ? 0 : done / total;
}
