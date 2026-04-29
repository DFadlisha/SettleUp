plugins {
    id("com.android.application")
    id("com.google.gms.google-services")  // Google services plugin for Firebase
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")  // Flutter Gradle plugin
}

android {
    namespace = "com.example.settleup"
    compileSdk = 35  // Updated to 35 as per recommendation
    ndkVersion = "27.0.12077973" // Updated as required by plugins


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
        targetSdk = 35  // Updated to 35

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
}


flutter {
    source = "../.."
}