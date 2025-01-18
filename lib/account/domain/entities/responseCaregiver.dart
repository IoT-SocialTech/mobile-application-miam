class ResponseCaregiver {
  final int id;
  final String name;
  final String address;
  final AccountCaregiver account;

  ResponseCaregiver({
    required this.id,
    required this.name,
    required this.address,
    required this.account,
  });

  factory ResponseCaregiver.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ResponseCaregiver(
      id: data['id'],
      name: data['name'],
      address: data['address'],
      account: AccountCaregiver.fromJson(data['account']),
    );
  }
}

class AccountCaregiver {
  final int id;
  final String email;
  final String password;
  final int phoneNumber;
  final String createdAt;
  final Role role;
  final Subscription subscription;
  final bool active;

  AccountCaregiver({
    required this.id,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.createdAt,
    required this.role,
    required this.subscription,
    required this.active,
  });

  factory AccountCaregiver.fromJson(Map<String, dynamic> json) {
    return AccountCaregiver(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      createdAt: json['createdAt'],
      role: Role.fromJson(json['role']),
      subscription: Subscription.fromJson(json['subscription']),
      active: json['active'],
    );
  }
}

class Role {
  final int id;
  final String type;
  final String description;

  Role({
    required this.id,
    required this.type,
    required this.description,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      type: json['type'],
      description: json['description'],
    );
  }
}

class Subscription {
  final int id;
  final String startDate;
  final String endDate;
  final bool isActive;
  final String type;
  final Plan plan;

  Subscription({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.type,
    required this.plan,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isActive: json['isActive'],
      type: json['type'],
      plan: Plan.fromJson(json['plan']),
    );
  }
}

class Plan {
  final int id;
  final String name;
  final String description;
  final double price;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
