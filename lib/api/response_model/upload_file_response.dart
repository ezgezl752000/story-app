/// errCode : 0
/// errDesc : "Upload successfully"
/// affileid : "A.AO.10058"
/// filename : "A.AO.10058_Biển báo 01.jpg"
/// filedownloaduri : "http://localhost:8383/filesrv/api/file/download/A.AO.10058_Bi%E1%BB%83n%20b%C3%A1o%2001.jpg?id=A.AO.10058"
/// filetype : "image/jpeg"
/// size : 1917842

class UploadFileResponse {
  UploadFileResponse({
      this.errCode, 
      this.errDesc, 
      this.affileid, 
      this.filename, 
      this.filedownloaduri, 
      this.filetype, 
      this.size,});

  UploadFileResponse.fromJson(dynamic json) {
    errCode = json['errCode'];
    errDesc = json['errDesc'];
    affileid = json['affileid'];
    filename = json['filename'];
    filedownloaduri = json['filedownloaduri'];
    filetype = json['filetype'];
    size = json['size'];
  }
  int? errCode;
  String? errDesc;
  String? affileid;
  String? filename;
  String? filedownloaduri;
  String? filetype;
  int? size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errCode'] = errCode;
    map['errDesc'] = errDesc;
    map['affileid'] = affileid;
    map['filename'] = filename;
    map['filedownloaduri'] = filedownloaduri;
    map['filetype'] = filetype;
    map['size'] = size;
    return map;
  }

}