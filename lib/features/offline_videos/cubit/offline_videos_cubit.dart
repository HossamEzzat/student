import 'package:flutter_bloc/flutter_bloc.dart';

part 'offline_videos_state.dart';

class OfflineVideosCubit extends Cubit<OfflineVideosState> {
  OfflineVideosCubit() : super(OfflineVideosInitial());
}
