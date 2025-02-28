import 'package:mobile_app/enums/view_state.dart';
import 'package:mobile_app/locator.dart';
import 'package:mobile_app/models/failure_model.dart';
import 'package:mobile_app/models/ib/ib_page_data.dart';
import 'package:mobile_app/models/ib/ib_pop_quiz_question.dart';
import 'package:mobile_app/services/ib_engine_service.dart';
import 'package:mobile_app/viewmodels/base_viewmodel.dart';

class IbPageViewModel extends BaseModel {
  // ViewState Keys
  String IB_FETCH_PAGE_DATA = 'ib_fetch_page_data';
  String IB_FETCH_INTERACTION_DATA = 'ib_fetch_interaction_data';
  String IB_FETCH_POP_QUIZ = 'ib_fetch_pop_quiz';

  final IbEngineService _ibEngineService = locator<IbEngineService>();

  IbPageData _pageData;
  IbPageData get pageData => _pageData;

  Future fetchPageData({String id = 'index.md'}) async {
    try {
      _pageData = await _ibEngineService.getPageData(id: id);

      setStateFor(IB_FETCH_PAGE_DATA, ViewState.Success);
    } on Failure catch (f) {
      setStateFor(IB_FETCH_PAGE_DATA, ViewState.Error);
      setErrorMessageFor(IB_FETCH_PAGE_DATA, f.message);
    }
  }

  Future fetchHtmlInteraction(String id) async {
    try {
      var result = await _ibEngineService.getHtmlInteraction(id);
      return result;
    } on Failure catch (f) {
      return f;
    }
  }

  List<IbPopQuizQuestion> fetchPopQuiz(String rawContent) {
    try {
      var result = _ibEngineService.getPopQuiz(rawContent);
      return result;
    } on Failure {
      return [];
    }
  }
}
