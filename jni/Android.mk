APP_PLATFORM := android-16
APP_PIE := true
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE            := sqlite3-a
LOCAL_MODULE_FILENAME   := libsqlite3
LOCAL_SRC_FILES         := ../build/sqlite3.c
LOCAL_C_INCLUDES        := ../build
LOCAL_EXPORT_C_INCLUDES := ../build
LOCAL_CFLAGS            := -Oz -fPIE -fstack-protector-strong -fno-rtti -fno-unroll-loops -fmerge-all-constants -fno-ident -D_FILE_OFFSET_BITS=64 -DSQLITE_THREADSAFE=1
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE            := sqlite3-cli
LOCAL_MODULE_FILENAME   := sqlite3
LOCAL_STATIC_LIBRARIES  := libsqlite3-a
LOCAL_SRC_FILES         := ../build/shell.c ../build/sqlite3.c
LOCAL_C_INCLUDES        := ../build
LOCAL_EXPORT_C_INCLUDES := ../build
LOCAL_CFLAGS            := -Oz -fPIE -fstack-protector-strong -fno-rtti -fno-unroll-loops -fmerge-all-constants -fno-ident -D_FILE_OFFSET_BITS=64 -DSQLITE_THREADSAFE=1
LOCAL_LDFLAGS           := -fstack-protector-strong -fPIE -pie -ffunction-sections -fdata-sections -Wl,--gc-sections -Wl,-z,norelro -Wl,--hash-style=both -Wl,--build-id=none
include $(BUILD_EXECUTABLE)
