class PaymentModel {
  String keyId;
  String amount; // Amount in main currency unit (e.g., rupees)
  String name;
  String description;
  String prefillEmail;
  String prefillContact;
  String? orderId; // Optional
  String currency;

  PaymentModel({
    required this.keyId,
    required this.amount,
    required this.name,
    required this.description,
    required this.prefillEmail,
    required this.prefillContact,
    this.orderId,
    this.currency = 'INR', // Default to INR
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = keyId;
    // Razorpay expects amount in the smallest currency unit (e.g., paisa for INR)
    data['amount'] = (double.parse(amount) * 100).round();
    data['currency'] = currency;
    data['name'] = name;
    data['description'] = description;
    data['prefill'] = {
      'contact': prefillContact,
      'email': prefillEmail,
    };
    if (orderId != null && orderId!.isNotEmpty) {
      data['order_id'] = orderId;
    }
    // Example: Add notes or theme
    // data['notes'] = {
    //   'address': 'Your Store Address'
    // };
    // data['theme'] = {'color': '#3399cc'};
    return data;
  }
}
