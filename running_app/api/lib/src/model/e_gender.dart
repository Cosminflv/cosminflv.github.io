//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'e_gender.g.dart';

class EGender extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 0)
  static const EGender number0 = _$number0;
  @BuiltValueEnumConst(wireNumber: 1)
  static const EGender number1 = _$number1;

  static Serializer<EGender> get serializer => _$eGenderSerializer;

  const EGender._(String name): super(name);

  static BuiltSet<EGender> get values => _$values;
  static EGender valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class EGenderMixin = Object with _$EGenderMixin;

