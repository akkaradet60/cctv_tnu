class Trainingcalendar {
  Trainingcalendar({
    required this.data,
    required this.error,
  });
  late final List<Data> data;
  late final bool error;

  Trainingcalendar.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['error'] = error;
    return _data;
  }
}

class Data {
  Data({
    required this.trainId,
    required this.trainName,
    required this.trainDetail,
    required this.trainStartDate,
    this.trainEnd,
    required this.trainUpdateDate,
    required this.trainCreateDate,
    required this.trainImages,
  });
  late final String trainId;
  late final String trainName;
  late final String trainDetail;
  late final String trainStartDate;
  late final Null trainEnd;
  late final String trainUpdateDate;
  late final String trainCreateDate;
  late final List<TrainImages> trainImages;

  Data.fromJson(Map<String, dynamic> json) {
    trainId = json['train_id'];
    trainName = json['train_name'];
    trainDetail = json['train_detail'];
    trainStartDate = json['train_start_date'];
    trainEnd = null;
    trainUpdateDate = json['train_update_date'];
    trainCreateDate = json['train_create_date'];
    trainImages = List.from(json['train_images'])
        .map((e) => TrainImages.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['train_id'] = trainId;
    _data['train_name'] = trainName;
    _data['train_detail'] = trainDetail;
    _data['train_start_date'] = trainStartDate;
    _data['train_end'] = trainEnd;
    _data['train_update_date'] = trainUpdateDate;
    _data['train_create_date'] = trainCreateDate;
    _data['train_images'] = trainImages.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TrainImages {
  TrainImages({
    required this.trainiId,
    required this.trainiTrainId,
    required this.trainiPathName,
    required this.trainiUpdateDate,
    required this.trainiCreateDate,
  });
  late final String trainiId;
  late final String trainiTrainId;
  late final String trainiPathName;
  late final String trainiUpdateDate;
  late final String trainiCreateDate;

  TrainImages.fromJson(Map<String, dynamic> json) {
    trainiId = json['traini_id'];
    trainiTrainId = json['traini_train_id'];
    trainiPathName = json['traini_path_name'];
    trainiUpdateDate = json['traini_update_date'];
    trainiCreateDate = json['traini_create_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['traini_id'] = trainiId;
    _data['traini_train_id'] = trainiTrainId;
    _data['traini_path_name'] = trainiPathName;
    _data['traini_update_date'] = trainiUpdateDate;
    _data['traini_create_date'] = trainiCreateDate;
    return _data;
  }
}
