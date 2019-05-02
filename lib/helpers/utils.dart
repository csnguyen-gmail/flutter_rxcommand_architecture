
const Map<String, String> MEDIA_TYPES = const {"dart": "application/dart", "js": "application/javascript", "html": "text/html; charset=UTF-8", "htm": "text/html; charset=UTF-8", "css": "text/css", "txt": "text/plain", "json": "application/json", "ico": "image/vnd.microsoft.icon", "png": "image/png", "jpg": "image/jpeg", "jpeg": "image/jpeg", "ogg": "audio/ogg", "ogv": "video/ogg", "mp3": "audio/mpeg", "mp4": "video/mp4", "pdf": "application/pdf"};

String getMediaType(String filename) {
  int dot = filename.lastIndexOf('.');
  if (dot != -1) {
    var fileType = filename.substring(dot + 1);
    var mediaType = MEDIA_TYPES[fileType];
    if (mediaType != null) {
      return mediaType;
    }
  }
  return "application/octet-stream";
}

bool isEmpty(String s) {
  return s == null || s.isEmpty;
}

bool isNotEmpty(String s) {
  return !isEmpty(s);
}
