import '../utils/HttpUtil.dart';

class AiApi {
  static textToImage(data) {
    return HttpUtil.post('/api/stable/generation/text-to-image', data: data);
  }
}
