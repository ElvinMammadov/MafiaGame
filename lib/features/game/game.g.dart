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
      wasBoomeranged: json['wasBoomeranged'] as bool? ?? false,
      wasSecured: json['wasSecured'] as bool? ?? false,
      targetId: (json['targetId'] as num?)?.toInt() ?? 0,
      canTarget: json['canTarget'] as bool? ?? true,
      killSecurity: json['killSecurity'] as bool? ?? false,
      isAnimated: json['isAnimated'] as bool? ?? true,
      playsAsCitizen: json['playsAsCitizen'] as bool? ?? true,
      beforeChange: json['beforeChange'] as bool? ?? true,
      healCount: (json['healCount'] as num?)?.toInt() ?? 2,
      wasVoted: json['wasVoted'] as bool? ?? false,
      roleCounts: (json['roleCounts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{
            '1': 0,
            '2': 0,
            '3': 0,
            '4': 0,
            '5': 0,
            '6': 0,
            '7': 0,
            '8': 0,
            '9': 0,
            '10': 0,
            '11': 0,
            '12': 0,
            '13': 0,
            '14': 0
          },
    );

Map<String, dynamic> _$GamerToJson(Gamer instance) => <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'imageUrl': instance.imageUrl,
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
      'wasBoomeranged': instance.wasBoomeranged,
      'wasSecured': instance.wasSecured,
      'targetId': instance.targetId,
      'canTarget': instance.canTarget,
      'killSecurity': instance.killSecurity,
      'roleCounts': instance.roleCounts,
      'isAnimated': instance.isAnimated,
      'playsAsCitizen': instance.playsAsCitizen,
      'beforeChange': instance.beforeChange,
      'healCount': instance.healCount,
      'wasVoted': instance.wasVoted,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
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
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Mafia _$MafiaFromJson(Map<String, dynamic> json) => Mafia(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$MafiaToJson(Mafia instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Don _$DonFromJson(Map<String, dynamic> json) => Don(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$DonToJson(Don instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Sheriff _$SheriffFromJson(Map<String, dynamic> json) => Sheriff(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$SheriffToJson(Sheriff instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Madam _$MadamFromJson(Map<String, dynamic> json) => Madam(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$MadamToJson(Madam instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Killer _$KillerFromJson(Map<String, dynamic> json) => Killer(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$KillerToJson(Killer instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Werewolf _$WerewolfFromJson(Map<String, dynamic> json) => Werewolf(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$WerewolfToJson(Werewolf instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Virus _$VirusFromJson(Map<String, dynamic> json) => Virus(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$VirusToJson(Virus instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Advokat _$AdvokatFromJson(Map<String, dynamic> json) => Advokat(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$AdvokatToJson(Advokat instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Security _$SecurityFromJson(Map<String, dynamic> json) => Security(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$SecurityToJson(Security instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Mirniy _$MirniyFromJson(Map<String, dynamic> json) => Mirniy(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$MirniyToJson(Mirniy instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Medium _$MediumFromJson(Map<String, dynamic> json) => Medium(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$MediumToJson(Medium instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Chameleon _$ChameleonFromJson(Map<String, dynamic> json) => Chameleon(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$ChameleonToJson(Chameleon instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };

Boomerang _$BoomerangFromJson(Map<String, dynamic> json) => Boomerang(
      name: json['name'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      points: (json['points'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$BoomerangToJson(Boomerang instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'points': instance.points,
    };
