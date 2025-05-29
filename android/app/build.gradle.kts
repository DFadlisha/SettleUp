plugins {
    id("com.android.application")
    id("com.google.gms.google-services")  // Google services plugin for Firebase
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")  // Flutter Gradle plugin
}

android {
    namespace = "com.example.settleup"
    compileSdk = 34  // Update to the latest stable SDK version
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.settleup"
        minSdk = 23  // Changed from minSdkVersion(23)
        targetSdk = 34  // Changed from targetSdkVersion(34)
        versionCode = 1  // Changed from versionCode(1)
        versionName = "1.0"  // Changed from versionName("1.0")
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")  // Debug signing config
        }
    }
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.13.0"))  // Firebase BoM

    // Firebase dependencies (add more as needed)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")  // Firebase Authentication
    implementation("com.google.firebase:firebase-firestore")  // Firestore (if needed)
}

flutter {
    source = "../.."
}