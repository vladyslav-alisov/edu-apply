enum UserRole {
  student("STUDENT"),
  superAdmin("SUPER_ADMIN"),
  managerUser("MANAGER_USER"),
  counsellor("COUNSELLOR"),
  worker("WORKER"),
  referrer("REFERRER"),
  unknown("UNKNOWN");

  const UserRole(this.json);

  final String json;
}
