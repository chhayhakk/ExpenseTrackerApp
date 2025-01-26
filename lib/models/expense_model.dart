class Expense {
  final int id;
  final double amount;
  final String category;
  final String date;
  final String? notes;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        id: json['ID'],
        amount: json['amount'],
        category: json['category'],
        date: json['date'],
        notes: json['notes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'cateogry': category,
      'date': date,
      'notes': notes,
    };
  }
}
