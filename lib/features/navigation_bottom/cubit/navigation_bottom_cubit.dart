import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_bottom_state.dart';

class NavigationBottomCubit extends Cubit<NavigationBottomState> {
  NavigationBottomCubit() : super(NavigationBottomInitial());
}
