import 'package:json_annotation/json_annotation.dart';

part 'estate_cascade_model.g.dart';

@JsonSerializable()
class EstateCascadeModel {
  final int id;
  final String name;
  final List<Unit> childList;

  factory EstateCascadeModel.fromJson(Map<String, dynamic> json) =>
      _$EstateCascadeModelFromJson(json);

  const EstateCascadeModel({
    required this.id,
    required this.name,
    required this.childList,
  });
}

@JsonSerializable()
class Unit {
  final int id;
  final String name;
  final int floor;
  final List<House> childList;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  List<Floor> get floors {
    var list = List.generate(
        floor,
        (index) =>
            Floor(name: '${index + 1}层', houses: _screenHouseByIndex(index)));
    return list;
  }

  List<House> _screenHouseByIndex(int index) {
    var list = <House>[];
    childList.forEach((element) {
      if (element.name.startsWith((index + 1).toString())) {
        list.add(element.copyWith());
      }
    });
    return list;
  }

  const Unit({
    required this.id,
    required this.name,
    required this.floor,
    required this.childList,
  });
}

@JsonSerializable()
class House {
  final int id;
  final String name;
  final String manageEstateTypeName;

  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);

  const House({
    required this.id,
    required this.name,
    required this.manageEstateTypeName,
  });

  House copyWith({
    int? id,
    String? name,
    String? manageEstateTypeName,
  }) {
    return House(
      id: id ?? this.id,
      name: name ?? this.name,
      manageEstateTypeName: manageEstateTypeName ?? this.manageEstateTypeName,
    );
  }
}

class Floor {
  final String name;
  final List<House> houses;

  const Floor({
    required this.name,
    required this.houses,
  });
}
