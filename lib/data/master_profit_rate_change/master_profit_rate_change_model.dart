import 'package:mindsight_admin_page/data/base_model.dart';

class MasterProfitRateChangeModel extends BaseModel {
  double? currentProfitRate;
  double? previousProfitRate;

  MasterProfitRateChangeModel({
    this.currentProfitRate,
    this.previousProfitRate,
  });

  MasterProfitRateChangeModel copyWith({
    double? currentProfitRate,
    double? previousProfitRate,
  }) =>
      MasterProfitRateChangeModel(
        currentProfitRate: currentProfitRate ?? this.currentProfitRate,
        previousProfitRate: previousProfitRate ?? this.previousProfitRate,
      );

  factory MasterProfitRateChangeModel.fromJson(Map<String, dynamic> json) =>
      MasterProfitRateChangeModel(
        currentProfitRate: json["currentProfitRate"]?.toDouble(),
        previousProfitRate: json["previousProfitRate"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "currentProfitRate": currentProfitRate,
        "previousProfitRate": previousProfitRate,
      };
}
