class UserData {
  final String uid, image, name, email, phone, position;
  final DateTime? createdAt;

  const UserData({
    this.uid = '',
    this.image = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.position = '',
    this.createdAt,
  });

  UserData copyWith({
    final String? uid,
    final String? image,
    final String? name,
    final String? email,
    final String? phone,
    final String? position,
    final DateTime? createdAt,
  }) =>
      UserData(
        uid: uid ?? this.uid,
        image: image ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        position: position ?? this.position,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserData.fromMap(Map<String, dynamic> map) => UserData(
        uid: map['uid'] ?? '',
        image: map['image'] ??
            'https://www.wildhareboca.com/wp-content/uploads/sites/310/2018/03/image-not-available.jpg',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        phone: map['phone'] ?? '',
        position: map['position'] ?? '',
        createdAt: map['createdAt'].toDate() ?? DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'image': image,
        'name': name,
        'email': email,
        'phone': phone,
        'position': position,
        'createdAt': createdAt,
      };

  @override
  String toString() =>
      'UserData(uid: $uid, image: $image, name: $name, email: $email, phone: $phone, position: $position,createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.uid == uid &&
        other.image == image &&
        other.name == name &&
        other.email == email &&
        other.position == position &&
        other.createdAt == createdAt &&
        other.phone == phone;
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      image.hashCode ^
      name.hashCode ^
      email.hashCode ^
      position.hashCode ^
      createdAt.hashCode ^
      phone.hashCode;
}
