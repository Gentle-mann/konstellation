class TimesModel {
  int whiteDuration, whiteIncrement, blackDuration, blackIncrement;
  bool useSeparateTimes, useIncrement;

  TimesModel({
    required this.whiteDuration,
    required this.whiteIncrement,
    required this.blackDuration,
    required this.blackIncrement,
    required this.useIncrement,
    required this.useSeparateTimes,
  });
  static final times = [
    TimesModel(
        whiteDuration: 10,
        whiteIncrement: 0,
        blackDuration: 5,
        blackIncrement: 3,
        useIncrement: true,
        useSeparateTimes: true),
    TimesModel(
        whiteDuration: 15,
        whiteIncrement: 0,
        blackDuration: 10,
        blackIncrement: 0,
        useIncrement: false,
        useSeparateTimes: true),
    TimesModel(
      whiteDuration: 10,
      whiteIncrement: 0,
      blackDuration: 10,
      blackIncrement: 0,
      useIncrement: true,
      useSeparateTimes: false,
    ),
    TimesModel(
        whiteDuration: 3,
        whiteIncrement: 2,
        blackDuration: 3,
        blackIncrement: 2,
        useIncrement: true,
        useSeparateTimes: true),
    TimesModel(
      whiteDuration: 20,
      whiteIncrement: 0,
      blackDuration: 10,
      blackIncrement: 0,
      useIncrement: true,
      useSeparateTimes: false,
    ),
  ];
}
