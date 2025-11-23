class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final bool read;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.read = false,
  });

  AppNotification copyWith({bool? read}) {
    return AppNotification(
      id: id,
      title: title,
      message: message,
      time: time,
      read: read ?? this.read,
    );
  }
}
