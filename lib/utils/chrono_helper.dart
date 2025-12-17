/// Helper utility for countdown chrono calculations and formatting.
/// Used by OrdinaryVisitController and TakeAttachmentController.

class ChronoHelper {
  /// Parses delay days from a string safely.
  /// Returns null if the string is null, empty, or not a valid integer.
  static int? parseDelayDays(String? delayExecuteDay) {
    if (delayExecuteDay == null || delayExecuteDay.trim().isEmpty) {
      return null;
    }
    return int.tryParse(delayExecuteDay.trim());
  }

  /// Parses a date string to DateTime safely.
  /// Returns null if the string is null, empty, or not a valid date.
  static DateTime? parseDateEffect(String? dateEffectStart) {
    if (dateEffectStart == null || dateEffectStart.trim().isEmpty) {
      return null;
    }
    try {
      return DateTime.parse(dateEffectStart.trim());
    } catch (_) {
      return null;
    }
  }

  /// Calculates the remaining duration for the countdown.
  ///
  /// Formula: remaining = (delayDays in days) - (now - dateEffect)
  ///
  /// Returns Duration.zero if the result is negative (deadline passed).
  /// Returns null if inputs are invalid (caller should show placeholder).
  static Duration? calculateRemaining({
    required String? delayExecuteDay,
    required String? dateEffectStart,
    DateTime? now,
  }) {
    final delayDays = parseDelayDays(delayExecuteDay);
    final dateEffect = parseDateEffect(dateEffectStart);

    if (delayDays == null || dateEffect == null) {
      return null;
    }

    final currentTime = now ?? DateTime.now();
    final totalDuration = Duration(days: delayDays);
    final elapsed = currentTime.difference(dateEffect);
    final remaining = totalDuration - elapsed;

    // Clamp at zero - never go negative
    return remaining.isNegative ? Duration.zero : remaining;
  }

  /// Formats a Duration into HH:MM:SS string.
  /// Returns placeholder if duration is null.
  static String formatHMS(Duration? duration) {
    if (duration == null) {
      return '-- : -- : --';
    }

    // Extract hours (total hours minus days*24 to get just the hour part)
    final totalHours = duration.inHours;
    final days = duration.inDays;
    final hoursInDay = totalHours - (days * 24);

    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return '${hoursInDay.toString().padLeft(2, '0')} : '
        '${minutes.toString().padLeft(2, '0')} : '
        '${seconds.toString().padLeft(2, '0')}';
  }

  /// Formats the days remaining text.
  /// Returns placeholder if duration is null.
  static String formatDaysRemaining(Duration? duration) {
    if (duration == null) {
      return '- jours restants';
    }
    final days = duration.inDays;
    return '$days jours restants';
  }

  /// Checks if the chrono data is valid and countdown can be started.
  static bool isChronoDataValid({
    required String? delayExecuteDay,
    required String? dateEffectStart,
  }) {
    return parseDelayDays(delayExecuteDay) != null &&
        parseDateEffect(dateEffectStart) != null;
  }
}
