
class LogSupplementModelData {
  bool? success;
  List<Data>? data;
  String? message;

  LogSupplementModelData({this.success, this.data, this.message});

  LogSupplementModelData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? amount;
  String? amountUnit;
  String? takenAtHuman;

  Data({this.id, this.name, this.amount, this.amountUnit, this.takenAtHuman});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    amountUnit = json['amount_unit'];
    takenAtHuman = json['taken_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['amount_unit'] = this.amountUnit;
    data['taken_at_human'] = this.takenAtHuman;
    return data;
  }
}
