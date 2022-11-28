class HttpResponseApi<T> {
  int? code = 400;
  String? message = "";
  String? status = "";
  T? data;
  dynamic dataError;
  bool? isLastPage;
  int? page;

  HttpResponseApi({this.code, this.message, this.data, this.dataError,this.status,this.isLastPage,this.page});

  HttpResponseApi.error({this.code = 500,this.status, this.message = "server error", this.data, this.dataError,this.isLastPage});
}
