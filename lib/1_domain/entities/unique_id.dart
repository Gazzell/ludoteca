import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class UniqueId with EquatableMixin {
  final String value;

  const UniqueId._(this.value);

  factory UniqueId() {
    return UniqueId._(const Uuid().v4());
  }

  factory UniqueId.fromUniqueString(String uniqueString) {
    return UniqueId._(uniqueString);
  }

  @override
  List<Object?> get props => [value];
}

class ItemId extends UniqueId {
  const ItemId._(super.value) : super._();

  factory ItemId() {
    return ItemId._(const Uuid().v4());
  }

  factory ItemId.fromUniqueString(String uniqueString) {
    return ItemId._(uniqueString);
  }
}
