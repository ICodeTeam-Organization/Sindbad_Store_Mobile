String validateLink(String link) {
  if (!link.startsWith("https://")) {
    return "https://icode-sendbad-store.runasp.net/$link";
  }
  return link;
}