ARCHS_IOS = x86_64-apple-ios aarch64-apple-ios
ARCHS_ANDROID = aarch64-linux-android armv7-linux-androideabi i686-linux-android
LIB=librustyphoneapp.a
all: ios android
ios: $(LIB)
android: $(ARCHS_ANDROID)
	sh copy_android.sh
.PHONY: $(ARCHS_IOS)
$(ARCHS_IOS): %:
	cargo build --target $@ --release
.PHONY: $(ARCHS_ANDROID)
$(ARCHS_ANDROID): %:
	cargo build --target $@ --release
$(LIB): $(ARCHS_IOS)
	lipo -create -output $@ $(foreach arch,$(ARCHS_IOS),$(wildcard target/$(arch)/release/$(LIB)))

