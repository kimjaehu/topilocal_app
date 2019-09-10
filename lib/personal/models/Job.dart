class PersonalJob {
  String title;
  String businessName;
  String location;
  String duration;
  String workDays;
  DateTime scheduleStart;
  DateTime scheduleEnd;
  double hrlyWage;
  DateTime expiry;

  PersonalJob(
    this.title,
    this.businessName,
    this.location,
    this.duration,
    this.workDays,
    this.scheduleStart,
    this.scheduleEnd,
    this.hrlyWage,
    this.expiry,
  );

  Map<String, dynamic> toJson() => {
        'title': title,
        'businessName': businessName,
        'location': location,
        'duration': duration,
        'workDays': workDays,
        'scheduleStart': scheduleStart,
        'scheduleEnd': scheduleEnd,
        'hrlyWage': hrlyWage,
        'expiry': expiry,
      };
}
