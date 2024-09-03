part of 'pictotext_bloc.dart';

enum TextStatus { initial, loading, success, failure }

final class PictotextState extends Equatable {
  const PictotextState({
    this.status = TextStatus.initial,
    this.items = const <ImageText>[],
  });

  final TextStatus status;
  final List<ImageText> items;

  PictotextState copyWith({
    TextStatus? status,
    List<ImageText>? items,
  }) {
    return PictotextState(
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [status, items];
}
