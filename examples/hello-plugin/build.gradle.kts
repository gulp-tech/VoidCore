plugins {
    java
}

group = "example"
version = "1.0.0"

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(25))
    }
}

dependencies {
    // Build the VoidCore server first: ./gradlew buildSkipChores
    compileOnly(files("../../build/VoidCore.jar"))
}

repositories {
    mavenCentral()
}
