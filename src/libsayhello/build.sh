#!/bin/bash
set -x 

rm -rf ./obj
rm -r ./lib
mkdir -p ./obj/x86_64
mkdir -p ./obj/armv7
mkdir -p ./obj/armv7s
mkdir -p ./obj/arm64
mkdir -p ./obj/arm64e
mkdir -p ./obj/macos

mkdir -p ./lib/ios
mkdir -p ./lib/macos

DEVDIR=`xcode-select -p`

# iOS
IOS_SIM_ROOT="$DEVDIR/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"
IOS_SDK_ROOT="$DEVDIR/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"

xcrun clang -arch x86_64 -isysroot $IOS_SIM_ROOT -c -o./obj/x86_64/say_hello.o say_hello.c
xcrun clang -fembed-bitcode -mthumb -arch armv7 -isysroot $IOS_SDK_ROOT -c -o./obj/armv7/say_hello.o say_hello.c
xcrun clang -fembed-bitcode -mthumb -arch armv7s -isysroot $IOS_SDK_ROOT -c -o./obj/armv7s/say_hello.o say_hello.c
xcrun clang -fembed-bitcode -arch arm64 -isysroot $IOS_SDK_ROOT -c -o./obj/arm64/say_hello.o say_hello.c
xcrun clang -fembed-bitcode -arch arm64e -isysroot $IOS_SDK_ROOT -c -o./obj/arm64e/say_hello.o say_hello.c

libtool -static -o ./lib/ios/libsayhello.a ./obj/x86_64/say_hello.o ./obj/armv7/say_hello.o ./obj/armv7s/say_hello.o ./obj/arm64/say_hello.o ./obj/arm64e/say_hello.o
libtool -o ./lib/ios/libsayhello.dylib ./obj/x86_64/say_hello.o ./obj/armv7/say_hello.o ./obj/armv7s/say_hello.o ./obj/arm64/say_hello.o ./obj/arm64e/say_hello.o

#MacOS
xcrun clang -target x86_64-apple-ios-macabi -arch arm64 -arch x86_64 -isysroot `xcrun --sdk macosx --show-sdk-path` -c -o./obj/macos/say_hello.o say_hello.c
libtool -static -o ./lib/macos/libsayhello.a ./obj/macos/say_hello.o
libtool  -o ./lib/macos/libsayhello.dylib ./obj/macos/say_hello.o