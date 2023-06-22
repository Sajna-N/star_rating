import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_ratings/bloc/star_handling_event.dart';
import 'package:star_ratings/bloc/star_handling_state.dart';

class StarHandlingBloc extends Bloc<RatingEvent, RatingState> {
  // RatingPageBloc() : super(RatingInitial());
  StarHandlingBloc() : super(RatingInitial()) {
    on<SubmitRating>((event, emit) {
      emit(RatingSubmitted(event.rating));
    });
  }
}
