import 'package:collection/collection.dart';

enum LeaderboardRanks {
  First,
  Second,
  Third,
}

enum GameMode {
  Tutorial,
  FreePlay,
  Real,
}

enum GameStep {
  Drop,
  Cover,
  HoldOn,
}

enum PlayError {
  OutOfTerm,
  Played,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (LeaderboardRanks):
      return LeaderboardRanks.values.deserialize(value) as T?;
    case (GameMode):
      return GameMode.values.deserialize(value) as T?;
    case (GameStep):
      return GameStep.values.deserialize(value) as T?;
    case (PlayError):
      return PlayError.values.deserialize(value) as T?;
    default:
      return null;
  }
}
