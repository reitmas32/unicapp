int indexWher2List<T>(List<T> primary, List<T> second, bool Function(T) test) {
  int primaryIndex = primary.indexWhere(test);
  int secondIndex = second.indexWhere(test);

  if (primaryIndex == -1 && secondIndex == -1) {
    return -3;
  }
  if (primaryIndex == -1) {
    return -2;
  }

  if (secondIndex == -1) {
    return -1;
  }
  return secondIndex;
}
