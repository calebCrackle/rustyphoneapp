extern crate libc;
extern crate rustybitcoin;

mod string;

use string::StringPtr;

#[no_mangle]
pub unsafe extern fn rust_string_ptr(s: *mut String) -> *mut StringPtr {
  Box::into_raw(Box::new(StringPtr::from(&**s)))
}

#[no_mangle]
pub unsafe extern fn rust_string_destroy(s: *mut String) {
  let _ = Box::from_raw(s);
}

#[no_mangle]
pub unsafe extern fn rust_string_ptr_destroy(s: *mut StringPtr) {
  let _ = Box::from_raw(s);
}

//Plugin Function for external library
pub fn invoke(request: String) -> String {
    rustybitcoin::invoke(request)
}

#[no_mangle]
pub unsafe extern fn rustInvoke(request: *mut StringPtr) -> *mut String {
  let request = (*request).as_str().to_string();
  let response = invoke(request);
  Box::into_raw(Box::new(response))
}

#[cfg(feature = "jni")]
#[allow(non_snake_case)]
pub mod android {
  extern crate jni;

  use self::jni::JNIEnv;
  use self::jni::objects::{JClass, JString};
  use self::jni::sys::jstring;

  use crate::invoke;

  #[no_mangle]
  pub unsafe extern fn Java_com_rustyphoneapp_RustBridge_rustInvoke(env: JNIEnv, _: JClass, request: JString) -> jstring {
    let request: String = env.get_string(request).unwrap().into();
    let response = invoke(request);
    env.new_string(response).unwrap().into_inner()
  }
}
