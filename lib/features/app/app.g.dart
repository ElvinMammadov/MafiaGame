// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
      user: json['user'] == null
          ? null
          : UserState.fromJson(json['user'] as Map<String, dynamic>),
      game: json['game'] == null
          ? null
          : GameState.fromJson(json['game'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'user': instance.user,
      'game': instance.game,
    };

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
      gameName: json['gameName'] as String,
      typeOfGame: json['typeOfGame'] as String,
      typeOfController: json['typeOfController'] as String,
      numberOfGamers: json['numberOfGamers'] as int,
      gameId: json['gameId'] as String,
      gamers: (json['gamers'] as List<dynamic>?)
          ?.map((e) => Gamer.fromJson(e as Map<String, dynamic>))
          .toList(),
      isGameCouldStart: json['isGameCouldStart'] as bool? ?? false,
      isGameStarted: json['isGameStarted'] as bool? ?? false,
      isDiscussionStarted: json['isDiscussionStarted'] as bool? ?? false,
      isVotingStarted: json['isVotingStarted'] as bool? ?? false,
      discussionTime: json['discussionTime'] as int? ?? 30,
      votingTime: json['votingTime'] as int? ?? 30,
      gameStartTime: json['gameStartTime'] == null
          ? null
          : DateTime.parse(json['gameStartTime'] as String),
      isDay: json['isDay'] as bool? ?? true,
      dayNumber: json['dayNumber'] as int? ?? 1,
      nightNumber: json['nightNumber'] as int? ?? 1,
    );

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'gameName': instance.gameName,
      'typeOfGame': instance.typeOfGame,
      'typeOfController': instance.typeOfController,
      'numberOfGamers': instance.numberOfGamers,
      'gameId': instance.gameId,
      'gamers': instance.gamers,
      'isGameCouldStart': instance.isGameCouldStart,
      'isGameStarted': instance.isGameStarted,
      'isDiscussionStarted': instance.isDiscussionStarted,
      'isVotingStarted': instance.isVotingStarted,
      'discussionTime': instance.discussionTime,
      'votingTime': instance.votingTime,
      'gameStartTime': instance.gameStartTime?.toIso8601String(),
      'isDay': instance.isDay,
      'dayNumber': instance.dayNumber,
      'nightNumber': instance.nightNumber,
    };

UserState _$UserStateFromJson(Map<String, dynamic> json) => UserState(
      id: json['id'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      token: json['token'] as int?,
      password: json['password'] as String?,
      accessToken: json['accessToken'] as String? ?? '',
    );

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'token': instance.token,
      'accessToken': instance.accessToken,
      'password': instance.password,
    };
