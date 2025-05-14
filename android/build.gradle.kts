import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

buildscript {
    val kotlinVersion by extra("1.9.0")

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
        classpath("com.google.gms:google-services:4.4.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Set custom build directory for root project
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

// Set custom build directory for all subprojects
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    layout.buildDirectory.set(newSubprojectBuildDir)
}

// Ensure app project is evaluated first
subprojects {
    evaluationDependsOn(":app")
}

// Define clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
