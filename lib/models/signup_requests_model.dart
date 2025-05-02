class SignupRequestsModel {
  List<PendingRequests>? pendingRequests;
  int? totalPendingRequest;
  int? currentPage;
  int? totalPages;

  SignupRequestsModel(
      {this.pendingRequests,
      this.totalPendingRequest,
      this.currentPage,
      this.totalPages});

  SignupRequestsModel.fromJson(Map<String, dynamic> json) {
    if (json['pendingRequests'] != null) {
      pendingRequests = <PendingRequests>[];
      json['pendingRequests'].forEach((v) {
        pendingRequests!.add(new PendingRequests.fromJson(v));
      });
    }
    totalPendingRequest = json['totalPendingRequest'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pendingRequests != null) {
      data['pendingRequests'] =
          this.pendingRequests!.map((v) => v.toJson()).toList();
    }
    data['totalPendingRequest'] = this.totalPendingRequest;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class PendingRequests {
  String? sId;
  String? fullName;
  String? email;
  String? createdAt;

  PendingRequests({this.sId, this.fullName, this.email, this.createdAt});

  PendingRequests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
