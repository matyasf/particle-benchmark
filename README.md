Particle simulators benchmark
==========


How to build
------------

Make sure you have Java 7 or newer installed

(OSX only) Make the file "gradlew" executable

Run "gradlew packageMobile" to make an .ipa

Run "gradlew installMobile" to install it on a connected USB device


IDE integration
---------------

Run "gradlew idea" to generate the an IntelliJ .iml module file; import this to a project. Run this every time you make changes to the build.gradle file. Then go to Project Structure -> Dependencies and set a Flex/AIR SDK (on the first build Gradle downloads it to /(Username)/.gradle/gradleFx/sdks).
