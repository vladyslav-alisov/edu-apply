enum AppRoutes {
  init("/", "/"),
  launchInitError("/launch_init_error", "/launch_init_error"),
  login("/login", "/login"),
  signUp("/sign_up", "/sign_up"),
  forgotPassword("/forgot_password", "/forgot_password"),
  onboarding("/onboarding", "/onboarding"),
  navigation("/navigation", "/navigation"),
  profileDetails("profile_details", "/navigation/profile_details"),
  profileContact("profile_contact", "/navigation/profile_contact"),
  profilePassport("profile_passport", "/navigation/profile_passport"),
  profileEducation("profile_education", "/navigation/profile_education"),
  profileLanguageCertificate("profile_language_certificate", "/navigation/profile_language_certificate"),
  profileAdditionalDocuments("profile_additional_documents", "/navigation/profile_additional_documents"),
  programDetails("program_details", "/navigation/program_details"),
  programApplicationOverview("program_application_overview", "/navigation/program_application_overview"),
  applicationLogs("application_logs", "/navigation/application_logs"),
  applicationDetails("application_details", "/navigation/application_details"),
  applicationFiles("application_files", "/navigation/application_files"),
  applicationComments("application_comments", "/navigation/application_comments");

  const AppRoutes(this.name, this.path);

  final String name;
  final String path;
}
