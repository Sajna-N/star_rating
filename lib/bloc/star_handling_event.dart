abstract class RatingEvent {}

class SubmitRating extends RatingEvent {
  final double rating;

  SubmitRating(this.rating);
}
