
class StaffModel {
  String staffUsername;

  StaffModel(
      {this.staffUsername,
      });

  StaffModel.fromJson(Map<String, dynamic> json) {
    staffUsername = json['staffUsername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffUsername'] = this.staffUsername;
    return data;
  }
}