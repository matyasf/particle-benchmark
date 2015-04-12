Particle simulators benchmark
==========


How to build
------------

Make sure you have Java 8 installed

Specify your certificates/mobile provision location and its name and password in the build.gradle file.

Comment out the iOS/Android part of the build script based on which one you want to build

(OSX only) Make the file "gradlew" executable

Run "gradlew packageMobile" to make an .ipa/apk

Run "gradlew installMobile" to install it on a connected USB device


IDE integration
---------------

Run "gradlew idea" to generate the an IntelliJ .iml module file; import this to a project. Run this every time you make changes to the build.gradle file. Then go to Project Structure -> Dependencies and set a Flex/AIR SDK (on the first build Gradle downloads it to /(Username)/.gradle/gradleFx/sdks).
