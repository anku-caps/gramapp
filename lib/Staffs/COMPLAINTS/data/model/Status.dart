class Status {
  // ignore: non_constant_identifier_names
  final String CID;
  final String complaint;
  final String mobile;
  final String id;
  final String add_status;

  // ignore: non_constant_identifier_names
  Status({this.CID, this.complaint, this.id, this.mobile, this.add_status});

  Status.fromMap(Map<String, dynamic> data, String id)
      : CID = data["CID"],
        complaint = data['complaint'],
        mobile = data['mobile'],
        add_status = data['add_status'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "CID": CID,
      "complaint": complaint,
      "mobile": mobile,
      "add_status": add_status
    };
  }
}
