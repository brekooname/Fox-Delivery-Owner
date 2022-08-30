class OfferModel{
  String? label;
  String? body;
  String? offerImage;


  OfferModel({
    required this.label,
    required this.body,
    required this.offerImage,

  });

  OfferModel.fromJson(Map<String, dynamic> json){
    label = json['label'];
    body = json['body'];
    offerImage = json['offerImage'];

  }

  Map<String, dynamic> toMap(){
    return {
      'label' : label,
      'body' : body,
      'offerImage' : offerImage,
    };
  }
}