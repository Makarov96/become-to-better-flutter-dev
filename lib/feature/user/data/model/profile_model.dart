import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:sample_dependecy_inversion/feature/user/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity with EquatableMixin {
  ProfileModel({
    required super.profileName,
  });

  @override
  List<Object> get props => [profileName];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'profileName': profileName});

    return result;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      profileName: map['profileName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));
}
