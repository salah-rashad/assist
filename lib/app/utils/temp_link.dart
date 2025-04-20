tempLink(String uri, [String? label]) {
  const leading = '\x1B]8;;';
  const trailing = '\x1B\\';
  return '$leading$uri$trailing$label$leading$trailing';
}
