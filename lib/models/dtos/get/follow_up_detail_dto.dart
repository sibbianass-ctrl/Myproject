/// DTO for status order service
class StatusOrderServiceDto {
  final String? status;

  StatusOrderServiceDto({this.status});

  factory StatusOrderServiceDto.fromJson(Map<String, dynamic>? json) {
    if (json == null) return StatusOrderServiceDto();
    return StatusOrderServiceDto(
      status: json['status']?.toString(),
    );
  }
}

/// DTO for a single follow-up detail item
class FollowUpDetailDto {
  final StatusOrderServiceDto? statusOrderService;
  final String? dateEffect;

  FollowUpDetailDto({
    this.statusOrderService,
    this.dateEffect,
  });

  factory FollowUpDetailDto.fromJson(Map<String, dynamic>? json) {
    if (json == null) return FollowUpDetailDto();
    return FollowUpDetailDto(
      statusOrderService: json['statusOrderService'] != null
          ? StatusOrderServiceDto.fromJson(
              json['statusOrderService'] as Map<String, dynamic>)
          : null,
      dateEffect: json['dateEffect']?.toString(),
    );
  }

  /// Check if this detail represents the "Démarrage" (start) status
  bool get isStartStatus =>
      statusOrderService?.status?.toLowerCase() == 'démarrage';
}

/// DTO for the following-up phases API response
class FollowingUpPhasesDto {
  final String? id;
  final List<FollowUpDetailDto> followUpDetails;

  FollowingUpPhasesDto({
    this.id,
    this.followUpDetails = const [],
  });

  factory FollowingUpPhasesDto.fromJson(Map<String, dynamic>? json) {
    if (json == null) return FollowingUpPhasesDto();

    List<FollowUpDetailDto> details = [];
    if (json['followUpDetails'] != null && json['followUpDetails'] is List) {
      details = (json['followUpDetails'] as List)
          .map((item) =>
              FollowUpDetailDto.fromJson(item as Map<String, dynamic>?))
          .toList();
    }

    return FollowingUpPhasesDto(
      id: json['id']?.toString(),
      followUpDetails: details,
    );
  }

  /// Get the dateEffect for the "Démarrage" status (official start date)
  String? get startDateEffect {
    try {
      final startDetail = followUpDetails.firstWhere(
        (detail) => detail.isStartStatus,
      );
      return startDetail.dateEffect;
    } catch (_) {
      return null;
    }
  }
}
