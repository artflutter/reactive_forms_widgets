/// A [Streamable] that provides synchronous access to the current [state].
abstract class StateStreamable<State> implements Streamable<State> {
  /// The current [state].
  State get state;
}

/// An object that provides access to a stream of states over time.
abstract class Streamable<State extends Object?> {
  /// The current [stream] of states.
  Stream<State> get stream;
}