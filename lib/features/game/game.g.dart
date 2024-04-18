// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gamer _$GamerFromJson(Map<String, dynamic> json) => Gamer(
      name: json['name'] as String?,
      role: json['role'] as String?,
      imageUrl: json['imageUrl'] as String?,
      id: json['id'] as int?,
      documentId: json['documentId'] as String?,
      gamerId: json['gamerId'] as String?,
      gamerCreated: json['gamerCreated'] as String?,
      isNameChanged: json['isNameChanged'] as bool?,
      foulCount: json['foulCount'] as int? ?? 0,
      votesCount: json['votesCount'] as int? ?? 0,
      wasDeleted: json['wasDeleted'] as bool? ?? false,
      gamerCreatedDate: json['gamerCreatedDate'] == null
          ? null
          : DateTime.parse(json['gamerCreatedDate'] as String),
      roleId: json['roleId'] as int?,
      positionOnTable: json['positionOnTable'] as int? ?? 0,
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
      'wasDeleted': instance.wasDeleted,
      'gamerCreatedDate': instance.gamerCreatedDate?.toIso8601String(),
      'roleId': instance.roleId,
      'positionOnTable': instance.positionOnTable,
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
