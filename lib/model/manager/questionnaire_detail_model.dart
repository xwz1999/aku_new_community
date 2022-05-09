import 'package:aku_new_community/model/common/img_model.dart';

class QuestionnaireDetialModel {
  int? id;
  String? title;
  String? description;
  String? beginDate;
  String? endDate;
  List<QuestionnaireTopicVoList>? questionnaireTopicVoList;
  List<ImgModel>? voResourcesImgList;

  QuestionnaireDetialModel(
      {this.id,
      this.title,
      this.description,
      this.beginDate,
      this.endDate,
      this.questionnaireTopicVoList,
      this.voResourcesImgList});

  QuestionnaireDetialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    if (json['appQuestionnaireFBITopicVoList'] != null) {
      questionnaireTopicVoList = [];
      json['appQuestionnaireFBITopicVoList'].forEach((v) {
        questionnaireTopicVoList!.add(new QuestionnaireTopicVoList.fromJson(v));
      });
    }
    if (json['imgList'] != null) {
      voResourcesImgList = [];
      json['imgList'].forEach((v) {
        voResourcesImgList!.add(new ImgModel.fromJson(v));
      });
    } else
      voResourcesImgList = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['beginDate'] = this.beginDate;
    data['endDate'] = this.endDate;
    if (this.questionnaireTopicVoList != null) {
      data['appQuestionnaireFBITopicVoList'] =
          this.questionnaireTopicVoList!.map((v) => v.toJson()).toList();
    }
    if (this.voResourcesImgList != null) {
      data['imgList'] =
          this.voResourcesImgList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionnaireTopicVoList {
  int? id;
  int? type;
  String? topic;
  List<QuestionnaireChoiceVoList>? questionnaireChoiceVoList;

  QuestionnaireTopicVoList(
      {this.id, this.type, this.topic, this.questionnaireChoiceVoList});

  QuestionnaireTopicVoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    topic = json['topic'];
    if (json['appQuestionnaireFBITopicChoiceVoList'] != null) {
      questionnaireChoiceVoList = [];
      json['appQuestionnaireFBITopicChoiceVoList'].forEach((v) {
        questionnaireChoiceVoList!
            .add(new QuestionnaireChoiceVoList.fromJson(v));
      });
    } else
      questionnaireChoiceVoList = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['topic'] = this.topic;
    if (this.questionnaireChoiceVoList != null) {
      data['appQuestionnaireFBITopicChoiceVoList'] =
          this.questionnaireChoiceVoList!.map((v) => v.toJson()).toList();
    } else
      questionnaireChoiceVoList = [];
    return data;
  }
}

class QuestionnaireChoiceVoList {
  int? id;
  String? options;
  String? answer;

  QuestionnaireChoiceVoList({this.id, this.options, this.answer});

  QuestionnaireChoiceVoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    options = json['options'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['options'] = this.options;
    data['answer'] = this.answer;
    return data;
  }
}
