Android

1. npm install
2. export NDK_HOME="/home/crackle/android-ndk"
3. export ANDROID_NDK_HOME="/home/crackle/android-ndk"
4. export ANDROID_HOME="/home/crackle/Android/Sdk"
5. sh ./create_ndk_standalone.sh
6. cd rust 
7. make android
8. cd ..
9. npm run android


IOS
1. npm install
2. cd rust
3. rustup target add x86_64-apple-ios
4. rustup target add aarch64-apple-ios
5. cargo build --release --target aarch64-apple-ios
6. cargo build --release --target x86_64-apple-ios
7. xcodebuild -create-xcframework -library target/aarch64-apple-ios/release/librustyphoneapp.a -headers ./headers -library target/x86_64-apple-ios/release/librustyphoneapp.a -headers ./headers -output rustyphoneapp.xcframework
8. cd ..
9. npm run ios

