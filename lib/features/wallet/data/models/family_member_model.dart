enum ContactMethod { email, phone }

class FamilyMemberModel {
  final String id;
  final String name;
  final String contact; // email or phone
  final ContactMethod contactMethod;

  FamilyMemberModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.contactMethod,
  });

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      contact: json['contact'] as String? ?? '',
      contactMethod: (json['contact_method'] as String?) == 'phone'
          ? ContactMethod.phone
          : ContactMethod.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'contact_method': contactMethod == ContactMethod.phone
          ? 'phone'
          : 'email',
    };
  }

  static List<FamilyMemberModel> get mockMembers => [
    FamilyMemberModel(
      id: 'fam_1',
      name: 'Sarah Johnson',
      contact: 'sarah.j@email.com',
      contactMethod: ContactMethod.email,
    ),
    FamilyMemberModel(
      id: 'fam_2',
      name: 'Mike Johnson',
      contact: '+1(555) 123-4567',
      contactMethod: ContactMethod.phone,
    ),
  ];
}
