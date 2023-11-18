typedef ApiDataBuilder<T> = List<T> Function(List<dynamic>);

class ApiData<T> {
  final List<T> data;

  ApiData({required this.data});

  factory ApiData.parseFromJson(Map<String, dynamic> map, ApiDataBuilder<T> builder) => ApiData(
    data: builder(map['data'])
  );
}