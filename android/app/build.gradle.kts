plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.easy_clinic"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.easy_clinic"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Two apps from one codebase. Each flavor gets its own applicationId so both
    // can be installed on the same device at once.
    //   Patient app: flutter run --flavor patient -t lib/main.dart
    //   Doctor app:  flutter run --flavor doctor  -t lib/main_doctor.dart
    flavorDimensions += "app"
    productFlavors {
        create("patient") {
            dimension = "app"
            // Keeps the original applicationId: com.example.easy_clinic
            manifestPlaceholders["appName"] = "Easy Clinic"
        }
        create("doctor") {
            dimension = "app"
            applicationIdSuffix = ".doctor"
            manifestPlaceholders["appName"] = "Easy Clinic Doctor"
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
