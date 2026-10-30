pluginManagement {
    repositories {
        // Mirrors the Gradle Plugin Portal for networks that reset direct portal requests.
        maven("https://maven.aliyun.com/repository/gradle-plugin")
        maven("https://maven.aliyun.com/repository/public")
        maven("https://mirrors.cloud.tencent.com/nexus/repository/maven-public/")
        gradlePluginPortal()
        mavenLocal()
        maven("https://jitpack.io")
        maven("https://repo.opencollab.dev/maven-releases/")
        maven("https://repo.opencollab.dev/maven-snapshots/") {
            mavenContent {
                snapshotsOnly()
            }
        }
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        mavenLocal()
        maven("https://mirrors.cloud.tencent.com/nexus/repository/maven-public/")
        maven("https://maven.aliyun.com/repository/public")
        maven("https://repo.powernukkitx.org/releases")
        maven("https://jitpack.io")
        maven("https://repo.opencollab.dev/maven-releases/")
        maven("https://repo.opencollab.dev/maven-snapshots/") {
            mavenContent {
                snapshotsOnly()
            }
        }
    }
}

rootProject.name = "VoidCore"

// Enable Gradle enterprise features for better build insights
enableFeaturePreview("STABLE_CONFIGURATION_CACHE")
enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS")
