🦀📱 Flutter + Rust Counter App

This project is a hybrid Flutter + Rust application demonstrating how to integrate native Rust logic into a Flutter frontend, using [`flutter_rust_bridge`](https://github.com/fzyzcjy/flutter_rust_bridge) for seamless FFI communication. The counter logic (increment, decrement, reset) is offloaded to Rust, while the UI and state management are handled in Flutter using BLoC architecture.

🚀 Features

 🔗 Rust Backend Integration
  All core counter logic is written in Rust. It's compiled to native and invoked from Flutter using FFI.

 🧠 BLoC State Management
  Uses `flutter_bloc` for clear separation of UI and business logic. Events like `Increment`, `Decrement`, and `Reset` are sent to the `CounterBloc`, which delegates logic to Rust.

 🔧 Cross-platform Support
  Works across Android, iOS, Linux, Windows, macOS, and Web (with some conditional compilation for native).

🛠️ Project Structure

```
flutter_rust/
├── lib/
    |--- /bloc
│   └── main.dart              # Flutter UI with BLoC
├── rust/
│   └── src/api.rs            # Rust logic (counter ops)
│   └── Cargo.toml            # Rust config
├── native/                   # flutter_rust_bridge-generated bindings
└── pubspec.yaml
```

📚 How It Works

1. Rust Code (Counter Logic)
   The Rust function takes a current count and an event string (`"inc"`, `"dec"`, `"reset"`) and returns a new count.

2. Flutter (BLoC)
   The BLoC handles UI events and calls Rust functions asynchronously using FFI.

3. Bridge
   The `flutter_rust_bridge` generates Dart bindings from Rust automatically so you can call Rust functions like any async Dart function.

✨ Insights for Developers

* Modular Design: Separating state logic (BLoC), UI, and backend (Rust) helps keep your app scalable and testable.
* Rust for Performance: Moving performance-critical or system-level logic to Rust is ideal in CPU-heavy scenarios.
* FFI Gotchas: Avoid panicking in Rust; always return `Result<T, E>` and handle errors gracefully in Flutter.
* flutter\_rust\_bridge handles a lot of the boilerplate, but make sure your Rust functions are `async`-compatible and use `async-std` or `tokio` as needed.

🧩 Future Ideas

* Add persistent storage (e.g., save the counter to file or SQLite from Rust).
* Encrypt data with Rust’s crypto libraries for secure apps.
* Expand to a full-featured notes app, calculator, or game engine prototype using this pattern.

---

🔗 References

* [flutter\_rust\_bridge](https://github.com/fzyzcjy/flutter_rust_bridge)
* [flutter\_bloc](https://bloclibrary.dev)
* [Rust FFI Guide](https://doc.rust-lang.org/nomicon/ffi.html)
