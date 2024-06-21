class ShippingCost {
  final String service;
  final String description;
  final int costValue;
  final String estimatedDeliveryTime;

  ShippingCost({
    required this.service,
    required this.description,
    required this.costValue,
    required this.estimatedDeliveryTime,
  });

  factory ShippingCost.fromJson(Map<String, dynamic> json) {
    return ShippingCost(
      service: json['service'],
      description: json['description'],
      costValue: json['cost'][0]['value'],
      estimatedDeliveryTime: json['cost'][0]['etd'],
    );
  }
}
