abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingSubmitted extends RatingState {
  final double rating;

  RatingSubmitted(this.rating);
}
