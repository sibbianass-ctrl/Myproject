# Keep Google error-prone annotations
-dontwarn com.google.errorprone.annotations.**
-keep class com.google.errorprone.annotations.** { *; }

# Keep javax.annotation classes
-dontwarn javax.annotation.**
-keep class javax.annotation.** { *; }

# Keep javax.annotation.concurrent classes
-dontwarn javax.annotation.concurrent.**
-keep class javax.annotation.concurrent.** { *; }