LOCAL_PATH:= $(call my-dir)
#======================================================================
#
#rgaCopyYuvTo565
#
#======================================================================
include $(CLEAR_VARS)
LOCAL_VENDOR_MODULE := true

LOCAL_CFLAGS += -DGL_GLEXT_PROTOTYPES -DEGL_EGLEXT_PROTOTYPES

LOCAL_CFLAGS += -DROCKCHIP_GPU_LIB_ENABLE

LOCAL_CFLAGS += -Wall -Werror -Wunreachable-code

LOCAL_C_INCLUDES += external/tinyalsa/include

LOCAL_C_INCLUDES += hardware/rockchip/librga
LOCAL_C_INCLUDES += hardware/rk29/librga

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    liblog \
    libutils \
    libbinder \
    libui \
    libEGL \
    libGLESv1_CM \
    libgui \
    libhardware \
    librga

#has no "external/stlport" from Android 6.0 on
ifeq (1,$(strip $(shell expr $(PLATFORM_VERSION) \< 6.0)))
LOCAL_C_INCLUDES += \
    external/stlport/stlport

LOCAL_SHARED_LIBRARIES += \
    libstlport

LOCAL_C_INCLUDES += bionic
endif

ifeq ($(strip $(BOARD_USE_DRM)), true)
ifneq (1,$(strip $(shell expr $(PLATFORM_VERSION) \< 6.9)))
LOCAL_CFLAGS += -DANDROID_7_DRM
endif
endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM)),rk3368)
LOCAL_CFLAGS += -DRK3368
endif

ifneq (1,$(strip $(shell expr $(PLATFORM_VERSION) \< 8.0)))
LOCAL_CFLAGS += -DANDROID_8
endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM)),rk3188)
LOCAL_CFLAGS += -DRK3188
endif

LOCAL_SRC_FILES:= \
	RockchipFileOps.cpp \
    rgaCopyYuvTo565.cpp

LOCAL_MODULE:= rgaCopyYuvTo565

ifdef TARGET_32_BIT_SURFACEFLINGER
LOCAL_32_BIT_ONLY := true
endif

include $(BUILD_EXECUTABLE)

