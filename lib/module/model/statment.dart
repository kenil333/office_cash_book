class Statment {
  final String id;
  final String name;
  final String remark;
  final bool debit;
  final DateTime date;
  final double amount;
  final double lastamount;

  Statment({
    required this.id,
    required this.name,
    required this.remark,
    required this.debit,
    required this.date,
    required this.amount,
    required this.lastamount,
  });
}
