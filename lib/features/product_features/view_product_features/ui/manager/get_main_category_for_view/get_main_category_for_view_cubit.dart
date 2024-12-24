import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_main_category_for_view_state.dart';

class GetMainCategoryForViewCubit extends Cubit<GetMainCategoryForViewState> {
  GetMainCategoryForViewCubit() : super(GetMainCategoryForViewInitial());
}
