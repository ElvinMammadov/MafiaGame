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
      games: (json['games'] as List<dynamic>?)
          ?.map((e) => GameState.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'user': instance.user,
      'game': instance.game,
      'games': instance.games,
    };

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
      gameId: json['gameId'] as String? ?? '',
      gameName: json['gameName'] as String? ?? '',
      typeOfGame: json['typeOfGame'] as String? ?? '',
      typeOfController: json['typeOfController'] as String? ?? '',
      numberOfGamers: (json['numberOfGamers'] as num?)?.toInt() ?? 0,
      gamers: (json['gamers'] as List<dynamic>?)
              ?.map((e) => Gamer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Gamer>[],
      discussionTime: (json['discussionTime'] as num?)?.toInt() ?? 30,
      votingTime: (json['votingTime'] as num?)?.toInt() ?? 30,
      gameStartTime: json['gameStartTime'] == null
          ? null
          : DateTime.parse(json['gameStartTime'] as String),
      dayNumber: (json['dayNumber'] as num?)?.toInt() ?? 1,
      nightNumber: (json['nightNumber'] as num?)?.toInt() ?? 1,
      mafiaCount: (json['mafiaCount'] as num?)?.toInt() ?? 0,
      civilianCount: (json['civilianCount'] as num?)?.toInt() ?? 0,
      isMafiaWin: json['isMafiaWin'] as bool? ?? false,
      roleIndex: (json['roleIndex'] as num?)?.toInt() ?? 0,
      currentVoter: json['currentVoter'] == null
          ? const Gamer.empty()
          : Gamer.fromJson(json['currentVoter'] as Map<String, dynamic>),
      votedGamers: (json['votedGamers'] as List<dynamic>?)
              ?.map((e) => Gamer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Gamer>[],
      infectedCount: (json['infectedCount'] as num?)?.toInt() ?? 0,
      gamePhase: $enumDecodeNullable(_$GamePhaseEnumMap, json['gamePhase']) ??
          GamePhase.IsReady,
      gamePeriod:
          $enumDecodeNullable(_$GamePeriodEnumMap, json['gamePeriod']) ??
              GamePeriod.Day,
    );

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'gameName': instance.gameName,
      'typeOfGame': instance.typeOfGame,
      'typeOfController': instance.typeOfController,
      'numberOfGamers': instance.numberOfGamers,
      'gameId': instance.gameId,
      'gamers': instance.gamers,
      'discussionTime': instance.discussionTime,
      'votingTime': instance.votingTime,
      'gameStartTime': instance.gameStartTime?.toIso8601String(),
      'dayNumber': instance.dayNumber,
      'nightNumber': instance.nightNumber,
      'mafiaCount': instance.mafiaCount,
      'civilianCount': instance.civilianCount,
      'isMafiaWin': instance.isMafiaWin,
      'roleIndex': instance.roleIndex,
      'currentVoter': instance.currentVoter,
      'votedGamers': instance.votedGamers,
      'infectedCount': instance.infectedCount,
      'gamePhase': _$GamePhaseEnumMap[instance.gamePhase]!,
      'gamePeriod': _$GamePeriodEnumMap[instance.gamePeriod]!,
    };

const _$GamePhaseEnumMap = {
  GamePhase.Discussion: 'Discussion',
  GamePhase.Voting: 'Voting',
  GamePhase.CouldStart: 'CouldStart',
  GamePhase.IsReady: 'IsReady',
  GamePhase.Started: 'Started',
  GamePhase.Finished: 'Finished',
};

const _$GamePeriodEnumMap = {
  GamePeriod.Day: 'Day',
  GamePeriod.Night: 'Night',
};

UserState _$UserStateFromJson(Map<String, dynamic> json) => UserState(
      id: json['id'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      token: (json['token'] as num?)?.toInt(),
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
