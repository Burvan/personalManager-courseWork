class Habit {
  final String title;
  final bool isAlreadyComplete;
  final int timeSpent;
  final int timeGoal;

  Habit({
    required this.title,
    required this.isAlreadyComplete,
    required this.timeGoal,
    required this.timeSpent,
  });

  Habit copyWith({
    String? title,
    bool? isAlreadyComplete,
    int? timeSpent,
    int? timeGoal,
  }) {
    return Habit(
      title: title ?? this.title,
      isAlreadyComplete: isAlreadyComplete ?? this.isAlreadyComplete,
      timeGoal: timeGoal ?? this.timeGoal,
      timeSpent: timeSpent ?? this.timeSpent,
    );
  }
}
