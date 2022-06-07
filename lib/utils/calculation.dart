class Calculation {
  static int getNumberSequence({required int maxNumber, required int index}) {
    if (index < maxNumber) return index;
    int newNum = index % maxNumber;
    return newNum;
  }
}
