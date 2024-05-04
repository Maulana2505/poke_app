// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StatsLoadEvent extends StatsEvent {
  final String url;
  StatsLoadEvent({
    required this.url,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [url];
}
