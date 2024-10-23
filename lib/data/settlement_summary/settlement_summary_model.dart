// settlement_summary_model.dart
import 'package:mindsight_admin_page/data/base_model.dart';

class SettlementSummaryModel extends BaseModel {
  double? totalSales;
  double? netSales;
  double? finalSales;
  int? playCount; // 추가된 필드

  SettlementSummaryModel({
    this.totalSales,
    this.netSales,
    this.finalSales,
    this.playCount,
  });

  SettlementSummaryModel copyWith({
    double? totalSales,
    double? netSales,
    double? finalSales,
    int? playCount,
  }) =>
      SettlementSummaryModel(
        totalSales: totalSales ?? this.totalSales,
        netSales: netSales ?? this.netSales,
        finalSales: finalSales ?? this.finalSales,
        playCount: playCount ?? this.playCount,
      );

  factory SettlementSummaryModel.fromJson(Map<String, dynamic> json) =>
      SettlementSummaryModel(
        totalSales: json["totalSales"]?.toDouble(),
        netSales: json["netSales"]?.toDouble(),
        finalSales: json["finalSales"]?.toDouble(),
        playCount: json["playCount"],
      );

  Map<String, dynamic> toJson() => {
        "totalSales": totalSales,
        "netSales": netSales,
        "finalSales": finalSales,
        "playCount": playCount,
      };
}
