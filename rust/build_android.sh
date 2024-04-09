#!/bin/bash

#Dependencies
rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
cargo install cargo-ndk

# Directories
RUST_MODULE_DIR="./"
REACT_NATIVE_ANDROID_DIR="../android/app/src/main"
LIB_NAME="librustyphoneapp.so"

# Build using cargo-ndk
cargo ndk --target aarch64-linux-android --platform 21 -- build --release
cargo ndk --target armv7-linux-androideabi --platform 21 -- build --release
cargo ndk --target i686-linux-android --platform 21 -- build --release
cargo ndk --target x86_64-linux-android --platform 21 -- build --release

# Copy the .so files to jniLibs folder
mkdir -p "$REACT_NATIVE_ANDROID_DIR/jniLibs/arm64-v8a"
mkdir -p "$REACT_NATIVE_ANDROID_DIR/jniLibs/armeabi-v7a"
mkdir -p "$REACT_NATIVE_ANDROID_DIR/jniLibs/x86"
mkdir -p "$REACT_NATIVE_ANDROID_DIR/jniLibs/x86_64"

cp "$RUST_MODULE_DIR/target/aarch64-linux-android/release/$LIB_NAME" "$REACT_NATIVE_ANDROID_DIR/jniLibs/arm64-v8a/"
cp "$RUST_MODULE_DIR/target/armv7-linux-androideabi/release/$LIB_NAME" "$REACT_NATIVE_ANDROID_DIR/jniLibs/armeabi-v7a/"
cp "$RUST_MODULE_DIR/target/i686-linux-android/release/$LIB_NAME" "$REACT_NATIVE_ANDROID_DIR/jniLibs/x86/"
cp "$RUST_MODULE_DIR/target/x86_64-linux-android/release/$LIB_NAME" "$REACT_NATIVE_ANDROID_DIR/jniLibs/x86_64/"

echo "Build completed and .so files copied successfully!"
