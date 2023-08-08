import 'package:mc_application/core/bases/base_model.dart';

abstract class BaseRepository<T extends BaseModel> {
  late String tableName;
  List<FieldStructure>? fields;
  T parseData(json);
  BaseRepository();
}

class FieldStructure {
  final String name;
  final String type;
  bool? isPrimary = false;
  FieldStructure(this.name, this.type, {this.isPrimary});
}
