import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lixshop/repositories/repositories.dart';

import '../../constants/env.dart';
import '../../models/models.dart';
import '../../utils/helpers/secure_storage.dart';

class ResultOutsideDataRepository {
  static final _dio = Dio();

  /*
   * @author: SONTV
   * @since: 04/04/2022 9:23 AM
   * @description: Lấy danh sách các danh mục, sản phẩm của màn hình chính gộp vào thành 1 danh sách
   * @update:
   *
   * */
  Future<ResultDataModel> getResultData() async {
    try {
      List<String> distLinks = await secureStorage.checkLogin()
          ? await userRepository.loadLocation()
          : [];
      var responses = await Future.wait([
        for (var link in distLinks)
          _dio.get("$baseUrl/datas/$link"),
      ]);
      ResultDataModel resultDataModel = _getProductCateFromResponse(responses);
      await secureStorage.addKey("idDist", resultDataModel.idNpp);
      await secureStorage.addKey("idAndNameDist", resultDataModel.idAndNameNpp);
      return resultDataModel;
    } on DioError catch (e) {
      print('getResultData error 1 : $e');
      return ResultDataModel.init();
    } catch (err) {
      print('getResultData error 2: $err');
      return ResultDataModel.init();
    }
  }

  /*
     * @author: SONTV
     * @since: 04/04/2022 9:17 AM
     * @description:
     *   - Có nhiều danh sách nhà phân phối, vì vậy mục đích là phải gộp các danh sách nhà phân phối thành 1 danh sách chung
     *   - Loại bỏ các dữ liệu không cần thiết (chỉ giữ id nhà phân phối, danh mục sản phẩm, sản phẩm)
     *     + Bước 1: Kiểm tra danh mục sản phẩm có trong danh sách nhà phân phối hay không
     *     + Bước 2: Nếu có thì kiểm tra sản phẩm trong danh mục
     *        + Bước 2.1: Nếu sản phẩm đã có thì bỏ qua, ngược lại thêm vào danh sách chung
     *        + Bước 2.2: Nếu không thì thêm vào danh sách chung
     *     + Bước 3: Nếu không thì thêm vào danh sách chung
     * @update:
     *
     * */
  ResultDataModel _getProductCateFromResponse(List<dynamic> responses) {
    //Khởi tạo danh sách danh mục sản phẩm ban đầu
    List<ProductOutsideCategory> productCatesMain = [];
    List<String> idDist = []; // tạo 1 danh sách id của nhà phân phối
    List<dynamic> idAndNameDist =
        []; // tạo 1 danh sách id và tên của nhà phân phối
    //(vòng lặp 1)
    // duyệt từng response
    for (var response in responses) {
      // ResultDataModel resultDataModel = ResultDataModel.fromJson(
      //     json.decode(response.data)); // chuyển json thành model (Dành cho link chính)
      ResultDataModel resultDataModel; // chuyển json thành model
      try {
        resultDataModel = ResultDataModel.fromJson(jsonDecode(response.data));
      } catch (e) {
        resultDataModel = ResultDataModel.fromJson((response.data));
      }
      idDist.add(resultDataModel.idNpp!); // thêm id nhà phân phối vào danh sách
      idAndNameDist.add({
        resultDataModel.idNpp: resultDataModel.nppName
      }); // thêm id và tên nhà phân phối vào danh sách

      //(vòng lặp 2)
      // Đi vào vòng lặp của từng danh mục sản phẩm
      for (var cate in resultDataModel.productOutsideCategory!) {
        //thêm biến bool 1 để kiểm tra
        bool statusMain = true;
        //(vòng lặp 3)
        //Duyệt dsdm khởi tạo ban đầu (nếu vòng lặp 2 lặp lần đầu thì danh sách này sẽ rỗng, không cần kiểm tra), nếu vòng lặp 2 lặp lần sau thì sẽ có danh sách đã có
        for (var cateMain in productCatesMain) {
          // nếu danh mục ban đầu trùng với danh mục đang xét thì vào bên trong
          if (cate.cateId == cateMain.cateId) {
            // thêm biến bool 2 để kiểm tra
            statusMain = false;
            //(vòng lặp 4)
            // Đi vào từng sản phẩm trong danh mục
            for (var brand in cate.productBrand!) {
              // thêm biến bool 3 để kiểm tra
              bool statusSub = true;
              for (var brandMain in cateMain.productBrand!) {
                //(vòng lặp 5)
                if (brandMain.brandId == brand.brandId) {
                  statusSub = false;
                  break;
                }
              }
              if (statusSub) {
                cateMain.productBrand!.add(brand);
              }
            }
          }
        }
        if (statusMain) {
          productCatesMain.add(cate);
        }
      }
    }
    ResultDataModel resultDataModel = ResultDataModel(
      idNpp: idDist.join(","),
      idAndNameNpp: idAndNameDist.isNotEmpty ? jsonEncode(idAndNameDist) : null,
      productOutsideCategory: productCatesMain,
    );
    return resultDataModel;
  }
}

final resultDataOutsideRepository = ResultOutsideDataRepository();
