import '../class/status_request.dart';

handlingData(var response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
