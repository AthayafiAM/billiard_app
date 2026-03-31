import 'booking_model.dart';

class BookingService {
  static final List<BookingModel> _bookings = [];

  static List<BookingModel> getBookings() {
    return _bookings;
  }

  static void addBooking(BookingModel booking) {
    _bookings.add(booking);
  }
}