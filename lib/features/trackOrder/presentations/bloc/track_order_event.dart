abstract class TrackOrderEvent {
  const TrackOrderEvent();
}

class TrackOrderStarted extends TrackOrderEvent {
  final String orderId;
  const TrackOrderStarted(this.orderId);
}
