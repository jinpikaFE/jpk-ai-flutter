import '../utils/DioManager.dart';

class AiApi {
  static textToImage(data) {
    return DioManager.post('/api/stable/generation/text-to-image', data: data);
  }
}
