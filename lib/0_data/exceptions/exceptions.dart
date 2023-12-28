class FailedRequestException implements Exception {
  final String message;
  FailedRequestException(this.message);
}

class ItemParseFailedException implements Exception {
  final String data;
  final String itemId;
  ItemParseFailedException(this.data, this.itemId);

  String get message {
    return 'Failed to parse item $itemId: $data';
  }
}
