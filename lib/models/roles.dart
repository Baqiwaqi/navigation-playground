
class Roles {
  final String role;

  Roles({this.role});
}

List<Roles> roles = List.generate(
    roleData.length,
    (index) => Roles(
          role: roleData[index]['role'],
        ));

List roleData = [
  {
    'role': 'supervisor',
  },
  {
    'role': 'operator',
  },
  {
    'role': 'admin',
  },
];
