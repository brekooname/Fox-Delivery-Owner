class PackageModel{
  String? clientFirstName;
  String? clientLastName;
  String? clientUid;
  String? packageName;
  int? packageId;
  String? toLocation;
  String? fromLocation;
  String? description;
  String? status;
  String? dateTime;
  String? dateTimeDisplay;

  PackageModel({
    required this.toLocation,
    required this.fromLocation,
    required this.clientUid,
    required this.clientFirstName,
    required this.clientLastName,
    required this.packageName,
    required this.packageId,
    required this.description,
    required this.status,
    required this.dateTime,
    required this.dateTimeDisplay,
  });

  PackageModel.fromJson(Map<String, dynamic> json) {
    toLocation = json['toLocation'];
    fromLocation = json['fromLocation'];
    clientFirstName = json['clientFirstName'];
    clientLastName = json['clientLastName'];
    clientUid = json['clientUid'];
    packageName = json['packageName'];
    packageId = json['packageId'];
    description = json['description'];
    status = json['status'];
    dateTime = json['dateTime'];
    dateTimeDisplay = json['dateTimeDisplay'];
  }

  Map<String, dynamic> toMap(){
    return {
      'toLocation' : toLocation,
      'fromLocation' : fromLocation,
      'clientFirstName' : clientFirstName,
      'clientLastName' : clientLastName,
      'clientUid' : clientUid,
      'packageName' : packageName,
      'packageId' : packageId,
      'description' : description,
      'status' : status,
      'dateTime' : dateTime,
      'dateTimeDisplay' : dateTimeDisplay,
    };
  }
}