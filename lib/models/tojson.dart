class Faq {
  String title;
  String cont;

  Faq({required this.title, required this.cont});

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(title: json['title'], cont: json['cont']);
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "cont": cont};
  }
}
