class GenericResponse {
  final bool? status;
  final String? message;
  final String? error;
  final String? token;
  final int? errorCode;
  final String? image;

  GenericResponse(Map<String, dynamic> resp)
      : status = resp['status'],
        message = resp['message'],
        error = resp['error'],
        token = resp['token'],
        errorCode = resp['ErrorCode'],
        image = resp['image'];

  static GenericResponse fromMap(Map<String, dynamic> resp) {
    return GenericResponse(resp);
  }

  bool get isSuccess {
    return status == true;
  }
}

class DummyResponse {
  DummyResponse(Map<String, dynamic> resp);

  static DummyResponse fromMap(Map<String, dynamic> resp) {
    return DummyResponse(resp);
  }
}

typedef ModelFromJson = dynamic Function(Map<String, dynamic> resp);

class ApiSingleResponse<T> extends GenericResponse {
  final T? data;

  ApiSingleResponse(this.data, Map<String, dynamic> resp) : super(resp);

  factory ApiSingleResponse.fromMap(
    Map<String, dynamic> resp,
    ModelFromJson fromJson,
  ) {
    var data = resp['data'];
    if (data == null ) {
      return ApiSingleResponse(null, resp);
    }

    if (data.runtimeType == int) {
      data = {'data': data};
    }

    if (data.runtimeType == String) {
      data = {'data': data};
    }

    final dt = data.cast<String, dynamic>();
    return ApiSingleResponse(fromJson(dt), resp);
  }
}

class ApiListResponse<T> extends GenericResponse {
  final List<T>? data;

  ApiListResponse(this.data, Map<String, dynamic> resp) : super(resp);

  factory ApiListResponse.fromMap(
    Map<String, dynamic> resp,
    ModelFromJson fromJson,
  ) {
    final data = resp['data'];
    if (data == null) {
      return ApiListResponse(null, resp);
    }

    final dt = data.cast<Map<String, dynamic>>();

    return ApiListResponse(
      List<T>.from(dt.map((item) => fromJson(item))),
      resp,
    );
  }
}
