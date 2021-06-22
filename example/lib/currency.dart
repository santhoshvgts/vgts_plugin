import 'package:vgts_plugin/form/base_object.dart';

class Currency extends BaseObject {

  int? id;
  String? name;

  int?  status;
  bool? deleted;
  String? createdAtTime;
  String? updatedAtTime;
  String? deletedAtTime;

  Currency({ this.id,
      this.name,
      this.status,
      this.deleted,
      this.createdAtTime,
      this.updatedAtTime,
      this.deletedAtTime
  });

  Future<Currency> fromMap(Map<String, dynamic> data) async {
    id = data["id"];
    name = data["name"];
    status = data["col_status"];
    deleted = data["col_deleted"] == 0;
    createdAtTime = data["col_created_at_time"];
    updatedAtTime = data["col_updated_at_time"];
    deletedAtTime = data["col_deleted_at_time"];
    return this;
  }

  Map<String, dynamic> toDatabaseMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["col_status"] = this.status;
    data["col_deleted"] = this.deleted;
    data["col_created_at_time"] = this.createdAtTime;
    data["col_updated_at_time"] = this.updatedAtTime;
    data["col_deleted_at_time"] = this.deletedAtTime;
    return data;
  }


}
