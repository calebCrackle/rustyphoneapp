#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct String RustString;

typedef struct StringPtr {
  const uint8_t *ptr;
  size_t len;
} RustStringPtr;

struct StringPtr *rust_string_ptr(struct String *s);

void rust_string_destroy(struct String *s);

void rust_string_ptr_destroy(struct StringPtr *s);

struct String *rustInvoke(struct StringPtr *name);
