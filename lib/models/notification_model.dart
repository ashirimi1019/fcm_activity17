/// Model class to represent a notification in the app
/// Used for storing notification history and displaying in UI
class NotificationModel {
  final String id;
  final String type; // 'regular' or 'important'
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.data,
    required this.timestamp,
  });

  /// Factory constructor to create from Firebase message data
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['messageId'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      type: map['data']?['type'] ?? 'regular',
      title: map['notification']?['title'] ?? 'No Title',
      body: map['notification']?['body'] ?? 'No Body',
      data: map['data'] ?? {},
      timestamp: DateTime.now(),
    );
  }

  /// Check if this is an important notification
  bool get isImportant => type == 'important';

  /// Convert to map for serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'body': body,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
