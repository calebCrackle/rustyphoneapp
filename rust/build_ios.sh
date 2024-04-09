#!/bin/bash

#Dependencies
rustup target add aarch64-apple-ios x86_64-apple-ios

# Build using cargo
cargo build --release --target aarch64-apple-ios
cargo build --release --target x86_64-apple-ios

# Copy the header file to xcode framework
rm -r rustyphoneapp.xcframework
xcodebuild -create-xcframework -library target/aarch64-apple-ios/release/librustyphoneapp.a -headers ./Headers -library target/x86_64-apple-ios/release/librustyphoneapp.a -headers ./Headers -output rustyphoneapp.xcframework

echo "Build completed and xcode-framework created successfully!"
