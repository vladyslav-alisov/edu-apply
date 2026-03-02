import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:edu_apply/core/const/enums/application_steps.dart';

enum ApplicationStatus {
  newApplication(
    json: "NEW_APPLICATION",
    textColor: Color(0xFF22C55E),
    bgColor: Color(0xFFBBF7D0),
    step: ApplicationSteps.one,
    iconData: Icons.app_registration, // Application icon
  ),
  processing(
    json: "PROCESSING",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.two,
    iconData: Icons.sync, // Processing icon
  ),
  missingRequirements(
    json: "MISSING_REQUIREMENTS",
    textColor: Color(0xFFF97316),
    bgColor: Color(0xFFFED7AA),
    step: ApplicationSteps.two,
    iconData: Icons.warning_amber, // Warning icon for missing requirements
  ),
  missingDocuments(
    json: "MISSING_DOCUMENTS",
    textColor: Color(0xFFF97316),
    bgColor: Color(0xFFFED7AA),
    step: ApplicationSteps.two,
    iconData: Icons.file_copy, // File icon for missing documents
  ),
  sentToUniversity(
    json: "SENT_TO_UNIVERSITY",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.three,
    iconData: Icons.send, // Send icon for sent to university
  ),
  admissionOffered(
    json: "ADMISSION_OFFERED",
    textColor: Color(0xFF22C55E),
    bgColor: Color(0xFFBBF7D0),
    step: ApplicationSteps.four,
    iconData: Icons.how_to_reg, // Registration icon for admission offered
  ),
  offerSent(
    json: "OFFER_SENT",
    textColor: Color(0xFF3B82F6),
    bgColor: Color(0xFFBFDBFE),
    step: ApplicationSteps.four,
    iconData: Icons.mark_email_read, // Email read icon for offer sent
  ),
  depositPaid(
    json: "DEPOSIT_PAID",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.five,
    iconData: Icons.attach_money, // Money icon for deposit paid
  ),
  waitingFinalAcceptance(
    json: "WAITING_FINAL_ACCEPTANCE",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.five,
    iconData: Icons.hourglass_empty, // Hourglass icon for waiting
  ),
  acceptanceLetterSent(
    json: "ACCEPTANCE_LETTER_SENT",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.six,
    iconData: Icons.email, // Email icon for acceptance letter sent
  ),
  visaApplied(
    json: "VISA_APPLIED",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.six,
    iconData: Icons.assignment, // Assignment icon for visa applied
  ),
  visaReceived(
    json: "VISA_RECEIVED",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.six,
    iconData: Icons.verified_user, // Verified icon for visa received
  ),
  waitingStudentCertificate(
    json: "WAITING_STUDENT_CERTIFICATE",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.seven,
    iconData: Icons.pending, // Pending icon for waiting
  ),
  refundRequest(
    json: "REFUND_REQUEST",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.seven,
    iconData: Icons.request_quote, // Quote icon for refund request
  ),
  enrolled(
    json: "ENROLLED",
    textColor: Color(0xFF22C55E),
    bgColor: Color(0xFFBBF7D0),
    step: ApplicationSteps.four,
    iconData: Icons.school, // School icon for enrolled
  ),
  rejected(
    json: "REJECTED",
    textColor: Color(0xFFEF4444),
    bgColor: Color(0xFFFECACA),
    step: ApplicationSteps.eight,
    iconData: Icons.cancel, // Cancel icon for rejected
  ),
  declined(
    json: "DECLINED",
    textColor: Color(0xFFEF4444),
    bgColor: Color(0xFFFECACA),
    step: ApplicationSteps.eight,
    iconData: Icons.thumb_down, // Thumb down icon for declined
  ),
  accepted(
    json: "ACCEPTED",
    textColor: Color(0xFF22C55E),
    bgColor: Color(0xFFBBF7D0),
    step: ApplicationSteps.eight,
    iconData: Icons.thumb_up, // Thumb up icon for accepted
  ),
  registered(
    json: "REGISTERED",
    textColor: Color(0xFFF97316),
    bgColor: Color(0xFFFED7AA),
    step: ApplicationSteps.eight,
    iconData: Icons.assignment_turned_in, // Assignment icon for registered
  ),
  frozen(
    json: "FROZEN",
    textColor: Color(0xFF6B7280),
    bgColor: Color(0xFFE5E7EB),
    step: ApplicationSteps.eight,
    iconData: Icons.ac_unit, // AC unit icon for frozen
  ),
  cancelled(
    json: "CANCELLED",
    textColor: Color(0xFF6B7280),
    bgColor: Color(0xFFE5E7EB),
    step: ApplicationSteps.eight,
    iconData: Icons.cancel_schedule_send, // Cancel schedule icon for cancelled
  ),
  dropped(
    json: "DROPPED",
    textColor: Color(0xFF6B7280),
    bgColor: Color(0xFFE5E7EB),
    step: ApplicationSteps.eight,
    iconData: Icons.arrow_downward, // Arrow down icon for dropped
  ),
  visaRejected(
    json: "VISA_REJECTED",
    textColor: Color(0xFFEF4444),
    bgColor: Color(0xFFFECACA),
    step: ApplicationSteps.eight,
    iconData: Icons.block, // Block icon for visa rejected
  ),
  refunded(
    json: "REFUNDED",
    textColor: Color(0xFFEAB308),
    bgColor: Color(0xFFFEF08A),
    step: ApplicationSteps.eight,
    iconData: Icons.money_off, // Money off icon for refunded
  );

  final String json;
  final Color textColor;
  final Color bgColor;
  final ApplicationSteps step;
  final IconData iconData;

  const ApplicationStatus({
    required this.json,
    required this.textColor,
    required this.bgColor,
    required this.step,
    required this.iconData,
  });

  String getTitle(BuildContext context) => switch (this) {
        ApplicationStatus.newApplication => "New Application",
        ApplicationStatus.processing => "Processing",
        ApplicationStatus.missingRequirements => "Missing Requirements",
        ApplicationStatus.missingDocuments => "Missing Documents",
        ApplicationStatus.sentToUniversity => "Sent To University",
        ApplicationStatus.admissionOffered => "Admission Offered",
        ApplicationStatus.enrolled => "Enrolled",
        ApplicationStatus.rejected => "Rejected",
        ApplicationStatus.declined => "Declined",
        ApplicationStatus.accepted => "Accepted",
        ApplicationStatus.registered => "Registered",
        ApplicationStatus.frozen => "Frozen",
        ApplicationStatus.cancelled => "Cancelled",
        ApplicationStatus.dropped => "Dropped",
        ApplicationStatus.offerSent => "Offer Sent",
        ApplicationStatus.depositPaid => "Deposit Paid",
        ApplicationStatus.waitingFinalAcceptance => "Waiting Final Acceptance",
        ApplicationStatus.acceptanceLetterSent => "Acceptance Letter Sent",
        ApplicationStatus.visaApplied => "Visa Applied",
        ApplicationStatus.visaReceived => "Visa Received",
        ApplicationStatus.visaRejected => "Visa Rejected",
        ApplicationStatus.waitingStudentCertificate =>
          "Waiting Student Certificate",
        ApplicationStatus.refundRequest => "Refund Request",
        ApplicationStatus.refunded => "Refunded",
      };

  static ApplicationStatus? fromString(String? value) {
    if (value == null) return null;
    return ApplicationStatus.values
        .firstWhereOrNull((e) => e.json == value.toUpperCase());
  }

  static int get totalSteps => ApplicationSteps.values.length;

  int get stepsLeft => totalSteps - step.number;
  double get progressPercentage => step.number / totalSteps;
}
