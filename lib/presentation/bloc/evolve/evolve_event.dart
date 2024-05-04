// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class EvolveEvent extends Equatable {
  @override
  
  List<Object?> get props => [];
}

class EvolveLoadEvent extends EvolveEvent {
  final String id;
  EvolveLoadEvent({
    required this.id,
  });
  @override
  
  List<Object?> get props => [id];
  
}
