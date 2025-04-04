class Task {
  final String id;
  final String title;
  final String description;
  final String route;
  final String cargoType;
  final DateTime datetime;
  final double price;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.route,
    required this.cargoType,
    required this.datetime,
    required this.price,
  });
}
