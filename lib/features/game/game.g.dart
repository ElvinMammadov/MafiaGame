// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gamer _$GamerFromJson(Map<String, dynamic> json) => Gamer(
      name: json['name'] as String? ?? '',
      role: json['role'] == null
          ? const Role.empty()
          : Role.fromJson(json['role'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
      documentId: json['documentId'] as String? ?? '',
      gamerId: json['gamerId'] as String? ?? '',
      gamerCreated: json['gamerCreated'] as String? ?? '',
      isNameChanged: json['isNameChanged'] as bool? ?? false,
      isRoleGiven: json['isRoleGiven'] as bool? ?? false,
      foulCount: (json['foulCount'] as num?)?.toInt() ?? 0,
      votesCount: (json['votesCount'] as num?)?.toInt() ?? 0,
      wasKilled: json['wasKilled'] as bool? ?? false,
      gamerCreatedDate: json['gamerCreatedDate'] == null
          ? null
          : DateTime.parse(json['gamerCreatedDate'] as String),
      positionOnTable: (json['positionOnTable'] as num?)?.toInt() ?? 0,
      selectedNumber: (json['selectedNumber'] as num?)?.toInt(),
      wasHealed: json['wasHealed'] as bool? ?? false,
      hasAlibi: json['hasAlibi'] as bool? ?? false,
      wasKilledByKiller: json['wasKilledByKiller'] as bool? ?? false,
      wasKilledByMafia: json['wasKilledByMafia'] as bool? ?? false,
      wasKilledBySheriff: json['wasKilledBySheriff'] as bool? ?? false,
      wasKilledByWerewolf: json['wasKilledByWerewolf'] as bool? ?? false,
      wasCheckedByMadam: json['wasCheckedByMadam'] as bool? ?? false,
      wasCheckedBySheriff: json['wasCheckedBySheriff'] as bool? ?? false,
      wasBoomeranged: json['wasBoomeranged'] as bool? ?? false,
      wasCheckedByMedium: json['wasCheckedByMedium'] as bool? ?? false,
      wasSecured: json['wasSecured'] as bool? ?? false,
      targetId: (json['targetId'] as num?)?.toInt() ?? 0,
      canTarget: json['canTarget'] as bool? ?? true,
      killSecurity: json['killSecurity'] as bool? ?? false,
      isAnimated: json['isAnimated'] as bool? ?? true,
      playsAsCitizen: json['playsAsCitizen'] as bool? ?? true,
      beforeChange: json['beforeChange'] as bool? ?? true,
      healCount: (json['healCount'] as num?)?.toInt() ?? 2,
      wasVoted: json['wasVoted'] as bool? ?? false,
      wasInfected: json['wasInfected'] as bool? ?? false,
      chameleonRoleType:
          $enumDecodeNullable(_$RoleTypeEnumMap, json['chameleonRoleType']) ??
              RoleType.Civilian,
      werewolfChanged: json['werewolfChanged'] as bool? ?? false,
      gamerCounts: json['gamerCounts'] == null
          ? const GamerCounts()
          : GamerCounts.fromJson(json['gamerCounts'] as Map<String, dynamic>),
      pointsId: json['pointsId'] as String? ?? '',
      hasImage: json['hasImage'] as bool? ?? false,
      newlyInfected: json['newlyInfected'] as bool? ?? false,
    );

Map<String, dynamic> _$GamerToJson(Gamer instance) => <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'imageUrl': instance.imageUrl,
      'hasImage': instance.hasImage,
      'id': instance.id,
      'documentId': instance.documentId,
      'gamerId': instance.gamerId,
      'gamerCreated': instance.gamerCreated,
      'isNameChanged': instance.isNameChanged,
      'isRoleGiven': instance.isRoleGiven,
      'foulCount': instance.foulCount,
      'votesCount': instance.votesCount,
      'wasKilled': instance.wasKilled,
      'gamerCreatedDate': instance.gamerCreatedDate?.toIso8601String(),
      'positionOnTable': instance.positionOnTable,
      'selectedNumber': instance.selectedNumber,
      'wasHealed': instance.wasHealed,
      'hasAlibi': instance.hasAlibi,
      'wasKilledByKiller': instance.wasKilledByKiller,
      'wasKilledByMafia': instance.wasKilledByMafia,
      'wasKilledBySheriff': instance.wasKilledBySheriff,
      'wasKilledByWerewolf': instance.wasKilledByWerewolf,
      'wasCheckedByMadam': instance.wasCheckedByMadam,
      'wasCheckedBySheriff': instance.wasCheckedBySheriff,
      'wasCheckedByMedium': instance.wasCheckedByMedium,
      'wasBoomeranged': instance.wasBoomeranged,
      'wasSecured': instance.wasSecured,
      'targetId': instance.targetId,
      'canTarget': instance.canTarget,
      'killSecurity': instance.killSecurity,
      'pointsId': instance.pointsId,
      'isAnimated': instance.isAnimated,
      'playsAsCitizen': instance.playsAsCitizen,
      'beforeChange': instance.beforeChange,
      'healCount': instance.healCount,
      'wasVoted': instance.wasVoted,
      'wasInfected': instance.wasInfected,
      'chameleonRoleType': _$RoleTypeEnumMap[instance.chameleonRoleType]!,
      'werewolfChanged': instance.werewolfChanged,
      'gamerCounts': instance.gamerCounts,
      'newlyInfected': instance.newlyInfected,
    };

const _$RoleTypeEnumMap = {
  RoleType.Chameleon: 'Chameleon',
  RoleType.Don: 'Don',
  RoleType.Mafia: 'Mafia',
  RoleType.Madam: 'Madam',
  RoleType.Sheriff: 'Sheriff',
  RoleType.Doctor: 'Doctor',
  RoleType.Advocate: 'Advocate',
  RoleType.Killer: 'Killer',
  RoleType.Boomerang: 'Boomerang',
  RoleType.Werewolf: 'Werewolf',
  RoleType.Medium: 'Medium',
  RoleType.Security: 'Security',
  RoleType.Virus: 'Virus',
  RoleType.Civilian: 'Civilian',
};

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Roles _$RolesFromJson(Map<String, dynamic> json) => Roles(
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RolesToJson(Roles instance) => <String, dynamic>{
      'roles': instance.roles,
    };

GamersState _$GamersStateFromJson(Map<String, dynamic> json) => GamersState(
      gamers: (json['gamers'] as List<dynamic>)
          .map((e) => Gamer.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles: Roles.fromJson(json['roles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GamersStateToJson(GamersState instance) =>
    <String, dynamic>{
      'gamers': instance.gamers,
      'roles': instance.roles,
    };

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Mafia _$MafiaFromJson(Map<String, dynamic> json) => Mafia(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$MafiaToJson(Mafia instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Don _$DonFromJson(Map<String, dynamic> json) => Don(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$DonToJson(Don instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Sheriff _$SheriffFromJson(Map<String, dynamic> json) => Sheriff(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$SheriffToJson(Sheriff instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Madam _$MadamFromJson(Map<String, dynamic> json) => Madam(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$MadamToJson(Madam instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Killer _$KillerFromJson(Map<String, dynamic> json) => Killer(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$KillerToJson(Killer instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Werewolf _$WerewolfFromJson(Map<String, dynamic> json) => Werewolf(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$WerewolfToJson(Werewolf instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Virus _$VirusFromJson(Map<String, dynamic> json) => Virus(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$VirusToJson(Virus instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Advocate _$AdvocateFromJson(Map<String, dynamic> json) => Advocate(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$AdvocateToJson(Advocate instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Security _$SecurityFromJson(Map<String, dynamic> json) => Security(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$SecurityToJson(Security instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Mirniy _$MirniyFromJson(Map<String, dynamic> json) => Mirniy(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$MirniyToJson(Mirniy instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Medium _$MediumFromJson(Map<String, dynamic> json) => Medium(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$MediumToJson(Medium instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Chameleon _$ChameleonFromJson(Map<String, dynamic> json) => Chameleon(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$ChameleonToJson(Chameleon instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

Boomerang _$BoomerangFromJson(Map<String, dynamic> json) => Boomerang(
      name: json['name'] as String? ?? '',
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.Civilian,
    );

Map<String, dynamic> _$BoomerangToJson(Boomerang instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
    };

GamerCounts _$GamerCountsFromJson(Map<String, dynamic> json) => GamerCounts(
      winnerCount: (json['winnerCount'] as num?)?.toInt() ?? 0,
      citizenCount: (json['citizenCount'] as num?)?.toInt() ?? 0,
      losingCount: (json['losingCount'] as num?)?.toInt() ?? 0,
      mafiaCount: (json['mafiaCount'] as num?)?.toInt() ?? 0,
      othersCount: (json['othersCount'] as num?)?.toInt() ?? 0,
      totalPlayedGames: (json['totalPlayedGames'] as num?)?.toInt() ?? 0,
      totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
      pointsHistory: (json['pointsHistory'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>).map(
                    (k, e) => MapEntry(k, e as Object),
                  ))
              .toList() ??
          const <Map<String, Object>>[],
    );

Map<String, dynamic> _$GamerCountsToJson(GamerCounts instance) =>
    <String, dynamic>{
      'winnerCount': instance.winnerCount,
      'citizenCount': instance.citizenCount,
      'losingCount': instance.losingCount,
      'mafiaCount': instance.mafiaCount,
      'othersCount': instance.othersCount,
      'totalPlayedGames': instance.totalPlayedGames,
      'totalPoints': instance.totalPoints,
      'pointsHistory': instance.pointsHistory,
    };
