LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := tinyxml

LOCAL_MODULE_FILENAME := tinyxml

LOCAL_SRC_FILES := \
../../src/tinystr.cpp \
../../src/tinyxml.cpp \
../../src/tinyxmlerror.cpp \
../../src/tinyxmlparser.cpp

LOCAL_C_INCLUDES := \
$(LOCAL_PATH)/../../inc

include $(BUILD_SHARED_LIBRARY)
