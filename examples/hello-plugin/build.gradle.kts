plugins {
    java
}

group = "example"
version = "1.0.0"

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

dependencies {
    // Build the VoidCore server first: ./gradlew buildSkipChores
    compileOnly(files("../../build/VoidCore.jar"))
}

repositories {
    mavenCentral()
}
