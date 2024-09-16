class CacheException implements Exception {}

class FailedRequestException implements Exception {
  final String message;
  FailedRequestException(this.message);
}

class ItemNotFoundException implements Exception {
  final String itemId;
  ItemNotFoundException(this.itemId);

  String get message {
    return 'Item $itemId not found';
  }
}

class ItemInstanceNotFoundException implements Exception {
  final String instanceId;
  ItemInstanceNotFoundException(this.instanceId);

  String get message {
    return 'Item instance $instanceId not found';
  }
}

class ItemParseFailedException implements Exception {
  final String data;
  final String itemId;
  ItemParseFailedException(this.data, this.itemId);

  String get message {
    return 'Failed to parse item $itemId: $data';
  }
}
