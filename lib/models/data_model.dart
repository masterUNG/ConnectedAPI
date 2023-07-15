// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataModel {
  final String created_at;
  final String start_at;
  final String end_at;
  final String location;
  final String event_name;
  final String topic_name_event;
  final int event_id;
  DataModel({
    required this.created_at,
    required this.start_at,
    required this.end_at,
    required this.location,
    required this.event_name,
    required this.topic_name_event,
    required this.event_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': created_at,
      'start_at': start_at,
      'end_at': end_at,
      'location': location,
      'event_name': event_name,
      'topic_name_event': topic_name_event,
      'event_id': event_id,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      created_at: (map['created_at'] ?? '') as String,
      start_at: (map['start_at'] ?? '') as String,
      end_at: (map['end_at'] ?? '') as String,
      location: (map['location'] ?? '') as String,
      event_name: (map['event_name'] ?? '') as String,
      topic_name_event: (map['topic_name_event'] ?? '') as String,
      event_id: (map['event_id'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) => DataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
