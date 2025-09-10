/*
DateTime Extensions
===================

Extensions for DateTime to add useful functionality for date manipulation,
formatting, and utility operations commonly needed in applications.
*/

extension DateTimeExtensions on DateTime {
  // Check if date is today
  bool get isToday {
    DateTime now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  // Check if date is yesterday
  bool get isYesterday {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  // Check if date is tomorrow
  bool get isTomorrow {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  // Check if date is in current week
  bool get isThisWeek {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    return isAfter(startOfWeek.subtract(Duration(days: 1))) &&
        isBefore(endOfWeek.add(Duration(days: 1)));
  }

  // Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  // Get end of day (23:59:59.999)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  // Get start of week (Monday)
  DateTime get startOfWeek => subtract(Duration(days: weekday - 1));

  // Get end of week (Sunday)
  DateTime get endOfWeek => startOfWeek.add(Duration(days: 6));

  // Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1);

  // Get end of month
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  // Get age in years
  int get age {
    DateTime now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  // Format as readable string
  String get readable {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    if (isTomorrow) return 'Tomorrow';

    DateTime now = DateTime.now();
    Duration difference = now.difference(this);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) return '1 day ago';
      if (difference.inDays < 7) return '${difference.inDays} days ago';
      if (difference.inDays < 30)
        return '${(difference.inDays / 7).floor()} weeks ago';
      if (difference.inDays < 365)
        return '${(difference.inDays / 30).floor()} months ago';
      return '${(difference.inDays / 365).floor()} years ago';
    } else {
      Duration futureDiff = difference.abs();
      if (futureDiff.inDays == 1) return 'In 1 day';
      if (futureDiff.inDays < 7) return 'In ${futureDiff.inDays} days';
      if (futureDiff.inDays < 30)
        return 'In ${(futureDiff.inDays / 7).floor()} weeks';
      if (futureDiff.inDays < 365)
        return 'In ${(futureDiff.inDays / 30).floor()} months';
      return 'In ${(futureDiff.inDays / 365).floor()} years';
    }
  }

  // Format as time ago string
  String get timeAgo {
    Duration difference = DateTime.now().difference(this);

    if (difference.inSeconds < 60) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30)
      return '${(difference.inDays / 7).floor()}w ago';
    if (difference.inDays < 365)
      return '${(difference.inDays / 30).floor()}mo ago';
    return '${(difference.inDays / 365).floor()}y ago';
  }

  // Check if it's a weekend
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  // Check if it's a weekday
  bool get isWeekday => !isWeekend;

  // Get quarter of the year (1-4)
  int get quarter => ((month - 1) ~/ 3) + 1;

  // Check if it's a leap year
  bool get isLeapYear {
    return (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0);
  }

  // Get days in current month
  int get daysInMonth => DateTime(year, month + 1, 0).day;

  // Add business days (excluding weekends)
  DateTime addBusinessDays(int days) {
    DateTime result = this;
    int addedDays = 0;

    while (addedDays < days) {
      result = result.add(Duration(days: 1));
      if (result.isWeekday) {
        addedDays++;
      }
    }

    return result;
  }

  // Format in different styles
  String format(String pattern) {
    // Simple pattern matching - in real apps, use intl package
    return pattern
        .replaceAll('yyyy', year.toString())
        .replaceAll('MM', month.toString().padLeft(2, '0'))
        .replaceAll('dd', day.toString().padLeft(2, '0'))
        .replaceAll('HH', hour.toString().padLeft(2, '0'))
        .replaceAll('mm', minute.toString().padLeft(2, '0'))
        .replaceAll('ss', second.toString().padLeft(2, '0'));
  }

  // Get zodiac sign
  String get zodiacSign {
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return 'Aries';
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return 'Taurus';
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return 'Gemini';
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return 'Cancer';
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return 'Leo';
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return 'Virgo';
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return 'Libra';
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21))
      return 'Scorpio';
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21))
      return 'Sagittarius';
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19))
      return 'Capricorn';
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18))
      return 'Aquarius';
    return 'Pisces';
  }
}

// Extension for Duration
extension DurationExtensions on Duration {
  // Format duration as readable string
  String get readable {
    if (inDays > 0) {
      return '${inDays}d ${inHours % 24}h ${inMinutes % 60}m';
    } else if (inHours > 0) {
      return '${inHours}h ${inMinutes % 60}m';
    } else if (inMinutes > 0) {
      return '${inMinutes}m ${inSeconds % 60}s';
    } else {
      return '${inSeconds}s';
    }
  }

  // Convert to different units
  double get inWeeks => inDays / 7;
  double get inMonths => inDays / 30.44; // Average month length
  double get inYears => inDays / 365.25; // Average year length
}

void demonstrateDateTimeExtensions() {
  print('=== DateTime Extensions Demo ===\n');

  DateTime now = DateTime.now();
  DateTime birthday = DateTime(1990, 5, 15);
  DateTime yesterday = now.subtract(Duration(days: 1));
  DateTime nextWeek = now.add(Duration(days: 7));

  print('Current date: $now');
  print('Is today: ${now.isToday}');
  print('Is weekend: ${now.isWeekend}');
  print('Quarter: ${now.quarter}');
  print('Days in month: ${now.daysInMonth}');
  print('Is leap year: ${now.isLeapYear}');
  print('Zodiac sign: ${now.zodiacSign}\n');

  print('Birthday: $birthday');
  print('Age: ${birthday.age} years');
  print('Zodiac sign: ${birthday.zodiacSign}');
  print('Readable: ${birthday.readable}\n');

  print('Yesterday: ${yesterday.readable}');
  print('Time ago: ${yesterday.timeAgo}');
  print('Next week: ${nextWeek.readable}\n');

  // Date ranges
  print('Start of day: ${now.startOfDay}');
  print('End of day: ${now.endOfDay}');
  print('Start of week: ${now.startOfWeek}');
  print('End of month: ${now.endOfMonth}\n');

  // Business days
  DateTime businessDate = now.addBusinessDays(5);
  print('5 business days from now: $businessDate\n');

  // Formatting
  print('Custom format: ${now.format('yyyy-MM-dd HH:mm:ss')}\n');

  // Duration extensions
  Duration duration = Duration(days: 5, hours: 3, minutes: 30);
  print('Duration: $duration');
  print('Readable duration: ${duration.readable}');
  print('In weeks: ${duration.inWeeks.toStringAsFixed(2)}');
}

void main() {
  demonstrateDateTimeExtensions();
}
