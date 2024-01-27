
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:felix_it_solutions/data/models/ads/ads_request.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/api_repository.dart';

part 'ads_event.dart';
part 'ads_state.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {

  final ApiRepository apiRepository;

  AdsBloc(this.apiRepository) : super(AdsInitial()) {
    on<PostAdsEvent>((event, emit) async{
      emit(AdsLoadingState());
      try{
        final res = await apiRepository.postAds(event.adsRequest);
        print(res);
        emit(AdsSuccessState());
      }
          catch(e){
            emit(AdsErrorState(errorText: e.toString()));
          }
    });
  }
}
