# TensorFlow Lite GPU
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**

# Keep Flutter-specific classes
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**
-keep class io.flutter.app.** { *; }
-dontwarn io.flutter.app.**

# Optional: Add other rules based on your dependencies
