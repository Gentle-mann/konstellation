class TimesModel {
  final int whiteDuration, whiteIncrement, blackDuration, blackIncrement;

  TimesModel({
    required this.whiteDuration,
    required this.whiteIncrement,
    required this.blackDuration,
    required this.blackIncrement,
  });
  static final times = [
    TimesModel(
        whiteDuration: 10,
        whiteIncrement: 5,
        blackDuration: 5,
        blackIncrement: 3),
    TimesModel(
        whiteDuration: 15,
        whiteIncrement: 5,
        blackDuration: 15,
        blackIncrement: 5),
    TimesModel(
        whiteDuration: 1,
        whiteIncrement: 0,
        blackDuration: 5,
        blackIncrement: 3),
    TimesModel(
        whiteDuration: 10,
        whiteIncrement: 0,
        blackDuration: 5,
        blackIncrement: 0),
    TimesModel(
        whiteDuration: 5,
        whiteIncrement: 2,
        blackDuration: 3,
        blackIncrement: 0),
  ];
}
