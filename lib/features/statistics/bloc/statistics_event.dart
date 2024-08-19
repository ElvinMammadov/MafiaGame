part of 'bloc.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();
}

class GetSearchData extends StatisticsEvent {
  final String searchQuery;
  const GetSearchData({required this.searchQuery});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetGamersForDate extends StatisticsEvent {
  final DateTime startDate;
  final DateTime endDate;

  const GetGamersForDate({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => <Object?>[
    startDate,
    endDate,
  ];
}
