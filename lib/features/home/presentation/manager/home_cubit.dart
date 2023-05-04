import '../../../../../lib_exports.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());
  
  int currentIndex = 0;

  void changeMenuTabs(int index) {
    currentIndex = index;
    emit(ChangeMenuTabs());
  }
}
