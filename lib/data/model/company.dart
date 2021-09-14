class Company {
  late String text;
  late bool selected;
  late String value;
  late String? color;
  late String? image;

  Company(this.text, this.selected, this.value, this.color, this.image);

  Company.fromMap(Map<String, dynamic> map) {
    text = map['text'];
    selected = map['selected'];
    value = map['value'];
    color = map['color'];
    image = map['image'];
  }
}
