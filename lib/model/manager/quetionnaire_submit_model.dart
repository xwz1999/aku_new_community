class QuestionnaireSubmitModel {
  int id;
  List<AppQuestionnaireAnswerSubmits> appQuestionnaireAnswerSubmits;

  QuestionnaireSubmitModel({this.id, this.appQuestionnaireAnswerSubmits});

  QuestionnaireSubmitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['appQuestionnaireAnswerSubmits'] != null) {
      appQuestionnaireAnswerSubmits = [];
      json['appQuestionnaireAnswerSubmits'].forEach((v) {
        appQuestionnaireAnswerSubmits
            .add(new AppQuestionnaireAnswerSubmits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.appQuestionnaireAnswerSubmits != null) {
      data['appQuestionnaireAnswerSubmits'] =
          this.appQuestionnaireAnswerSubmits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppQuestionnaireAnswerSubmits {
  int topicId;
  List<int> choiceAnswer;
  String shortAnswer;

  AppQuestionnaireAnswerSubmits(
      {this.topicId, this.choiceAnswer, this.shortAnswer});

  AppQuestionnaireAnswerSubmits.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    choiceAnswer = json['choiceAnswer'].cast<int>();
    shortAnswer = json['shortAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicId'] = this.topicId;
    data['choiceAnswer'] = this.choiceAnswer;
    data['shortAnswer'] = this.shortAnswer;
    return data;
  }
}
