// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gamer _$GamerFromJson(Map<String, dynamic> json) => Gamer(
      name: json['name'] as String?,
      role: json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String?,
      id: json['id'] as int?,
      documentId: json['documentId'] as String?,
      gamerId: json['gamerId'] as String?,
      gamerCreated: json['gamerCreated'] as String?,
      isNameChanged: json['isNameChanged'] as bool?,
      foulCount: json['foulCount'] as int? ?? 0,
      votesCount: json['votesCount'] as int? ?? 0,
      wasKilled: json['wasKilled'] as bool? ?? false,
      gamerCreatedDate: json['gamerCreatedDate'] == null
          ? null
          : DateTime.parse(json['gamerCreatedDate'] as String),
      positionOnTable: json['positionOnTable'] as int? ?? 0,
      selectedNumber: json['selectedNumber'] as int?,
      wasHealed: json['wasHealed'] as bool? ?? false,
      hasAlibi: json['hasAlibi'] as bool? ?? false,
      wasKilledByKiller: json['wasKilledByKiller'] as bool? ?? false,
      wasKilledByMafia: json['wasKilledByMafia'] as bool? ?? false,
      wasKilledBySheriff: json['wasKilledBySheriff'] as bool? ?? false,
      wasBumeranged: json['wasBumeranged'] as bool? ?? false,
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
      'wasBumeranged': instance.wasBumeranged,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      json['name'] as String,
      roleId: json['roleId'] as int? ?? 0,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
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
      name: json['name'] as String,
      roleId: json['roleId'] as int,
      healCount: json['healCount'] as int,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'healCount': instance.healCount,
    };

Mafia _$MafiaFromJson(Map<String, dynamic> json) => Mafia(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$MafiaToJson(Mafia instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Don _$DonFromJson(Map<String, dynamic> json) => Don(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$DonToJson(Don instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Sheriff _$SheriffFromJson(Map<String, dynamic> json) => Sheriff(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$SheriffToJson(Sheriff instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Madam _$MadamFromJson(Map<String, dynamic> json) => Madam(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$MadamToJson(Madam instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Killer _$KillerFromJson(Map<String, dynamic> json) => Killer(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$KillerToJson(Killer instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Werewolf _$WerewolfFromJson(Map<String, dynamic> json) => Werewolf(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$WerewolfToJson(Werewolf instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Virus _$VirusFromJson(Map<String, dynamic> json) => Virus(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$VirusToJson(Virus instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Advokat _$AdvokatFromJson(Map<String, dynamic> json) => Advokat(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$AdvokatToJson(Advokat instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Security _$SecurityFromJson(Map<String, dynamic> json) => Security(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$SecurityToJson(Security instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Mirniy _$MirniyFromJson(Map<String, dynamic> json) => Mirniy(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$MirniyToJson(Mirniy instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Medium _$MediumFromJson(Map<String, dynamic> json) => Medium(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$MediumToJson(Medium instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Chameleon _$ChameleonFromJson(Map<String, dynamic> json) => Chameleon(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$ChameleonToJson(Chameleon instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };

Boomerang _$BoomerangFromJson(Map<String, dynamic> json) => Boomerang(
      name: json['name'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$BoomerangToJson(Boomerang instance) => <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
    };
