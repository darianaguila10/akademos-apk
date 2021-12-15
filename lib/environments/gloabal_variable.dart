class GlobalVariables {
  static final GlobalVariables _globalVariables = GlobalVariables._internal();

  static int numberStarts = 0;

  static get getnumberStarts => numberStarts;

  static addNumberStarts({int value=1}) {
    numberStarts += value;
  }

  factory GlobalVariables() {
    return _globalVariables;
  }

  GlobalVariables._internal();
}
