import 'package:mindsight_admin_page/data/base_model.dart';

class PurchaseListModel extends BaseModel {
  List<String>? id;
  List<String>? buyer;
  List<String>? email;
  List<DateTime>? transactionDate;
  List<DateTime>? cancellationDate;
  List<String>? membershipName;
  List<double>? amount;
  List<String>? approvalNumber;
  List<String>? paymentGateway;
  List<double>? fee;
  List<double>? netSales;
  List<double>? otherFees;
  List<double>? finalSales;
  int? total;

  PurchaseListModel({
    this.id,
    this.buyer,
    this.email,
    this.transactionDate,
    this.cancellationDate,
    this.membershipName,
    this.amount,
    this.approvalNumber,
    this.paymentGateway,
    this.fee,
    this.netSales,
    this.otherFees,
    this.finalSales,
    this.total,
  });

  PurchaseListModel copyWith({
    List<String>? id,
    List<String>? buyer,
    List<String>? email,
    List<DateTime>? transactionDate,
    List<DateTime>? cancellationDate,
    List<String>? membershipName,
    List<double>? amount,
    List<String>? approvalNumber,
    List<String>? paymentGateway,
    List<double>? fee,
    List<double>? netSales,
    List<double>? otherFees,
    List<double>? finalSales,
    int? total,
  }) =>
      PurchaseListModel(
        id: id ?? this.id,
        buyer: buyer ?? this.buyer,
        email: email ?? this.email,
        transactionDate: transactionDate ?? this.transactionDate,
        cancellationDate: cancellationDate ?? this.cancellationDate,
        membershipName: membershipName ?? this.membershipName,
        amount: amount ?? this.amount,
        approvalNumber: approvalNumber ?? this.approvalNumber,
        paymentGateway: paymentGateway ?? this.paymentGateway,
        fee: fee ?? this.fee,
        netSales: netSales ?? this.netSales,
        otherFees: otherFees ?? this.otherFees,
        finalSales: finalSales ?? this.finalSales,
        total: total ?? this.total,
      );

  factory PurchaseListModel.fromJson(Map<String, dynamic> json) =>
      PurchaseListModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        buyer: json["buyer"] == null
            ? []
            : List<String>.from(json["buyer"]!.map((x) => x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        transactionDate: json["transactionDate"] == null
            ? []
            : List<DateTime>.from(
                json["transactionDate"]!.map((x) => DateTime.parse(x))),
        cancellationDate: json["cancellationDate"] == null
            ? []
            : List<DateTime>.from(json["cancellationDate"]!
                .map((x) => x == null ? '-' : DateTime.parse(x))),
        membershipName: json["membershipName"] == null
            ? []
            : List<String>.from(json["membershipName"]!.map((x) => x)),
        amount: json["amount"] == null
            ? []
            : List<double>.from(json["amount"]!.map((x) => x.toDouble())),
        approvalNumber: json["approvalNumber"] == null
            ? []
            : List<String>.from(json["approvalNumber"]!.map((x) => x)),
        paymentGateway: json["paymentGateway"] == null
            ? []
            : List<String>.from(json["paymentGateway"]!.map((x) => x)),
        fee: json["fee"] == null
            ? []
            : List<double>.from(json["fee"]!.map((x) => x.toDouble())),
        netSales: json["netSales"] == null
            ? []
            : List<double>.from(json["netSales"]!.map((x) => x.toDouble())),
        otherFees: json["otherFees"] == null
            ? []
            : List<double>.from(json["otherFees"]!.map((x) => x.toDouble())),
        finalSales: json["finalSales"] == null
            ? []
            : List<double>.from(json["finalSales"]!.map((x) => x.toDouble())),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "buyer": buyer == null ? [] : List<dynamic>.from(buyer!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "transactionDate": transactionDate == null
            ? []
            : List<dynamic>.from(
                transactionDate!.map((x) => x.toIso8601String())),
        "cancellationDate": cancellationDate == null
            ? []
            : List<dynamic>.from(
                cancellationDate!.map((x) => x.toIso8601String())),
        "membershipName": membershipName == null
            ? []
            : List<dynamic>.from(membershipName!.map((x) => x)),
        "amount":
            amount == null ? [] : List<dynamic>.from(amount!.map((x) => x)),
        "approvalNumber": approvalNumber == null
            ? []
            : List<dynamic>.from(approvalNumber!.map((x) => x)),
        "paymentGateway": paymentGateway == null
            ? []
            : List<dynamic>.from(paymentGateway!.map((x) => x)),
        "fee": fee == null ? [] : List<dynamic>.from(fee!.map((x) => x)),
        "netSales":
            netSales == null ? [] : List<dynamic>.from(netSales!.map((x) => x)),
        "otherFees": otherFees == null
            ? []
            : List<dynamic>.from(otherFees!.map((x) => x)),
        "finalSales": finalSales == null
            ? []
            : List<dynamic>.from(finalSales!.map((x) => x)),
        "total": total,
      };
}
