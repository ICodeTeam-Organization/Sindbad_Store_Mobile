import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_brands_by_category_id_state.dart';

class GetBrandsByCategoryIdCubit extends Cubit<GetBrandsByCategoryIdState> {
  GetBrandsByCategoryIdCubit() : super(GetBrandsByCategoryIdInitial());
}
