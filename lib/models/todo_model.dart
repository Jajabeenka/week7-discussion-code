/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample friend app with networking
*/

import 'dart:convert';
//manipulate model to fit to what is needed
class Friend {
  final String id;
  String? userName;
  String displayName;
  List<dynamic>? friends;
  List<dynamic>? receivedFriendRequests;
  List<dynamic>? sentFriendRequest;

  Friend({
    required this.id,
    this.userName,
    required this.displayName,
    this.friends,
    this.receivedFriendRequests,
    this.sentFriendRequest,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      userName: json['userName'],
      displayName: json['displayName'],
      friends: json['friends'],
      receivedFriendRequests: json['receivedFriendRequests'],
      sentFriendRequest: json['sentFriendRequests'],
    );
  }

  static List<Friend> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Friend>((dynamic d) => Friend.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Friend friend) {
    return {
      'id': friend.id,
      'displayName': friend.displayName,
      'friends': friend.friends,
      'receivedFriendRequests': friend.receivedFriendRequests,
      'sentFriendRequests': friend.sentFriendRequest,
    };
  }
}
