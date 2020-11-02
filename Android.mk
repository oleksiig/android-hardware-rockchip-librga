LOCAL_PATH:= $(call my-dir)
#================================================================

ifeq ($(strip $(BOARD_USE_DRM)), true)
include $(CLEAR_VARS)

$(info $(shell $(LOCAL_PATH)/version.sh))

LOCAL_SRC_FILES += \
    RockchipRga.cpp \
    GraphicBuffer.cpp \
    normal/NormalRga.cpp \
    normal/NormalRgaApi.cpp

LOCAL_MODULE := librga
LOCAL_VENDOR_MODULE := true
LOCAL_C_INCLUDES += external/libdrm/rockchip
LOCAL_C_INCLUDES += hardware/rockchip/libgralloc
LOCAL_C_INCLUDES += hardware/libhardware/include
LOCAL_C_INCLUDES += hardware/libhardware/modules/gralloc

LOCAL_SHARED_LIBRARIES += \
	libdrm \
	libdrm_rockchip \
	liblog \
	libui \
	libEGL \
	libGLESv2 \
	libGLESv1_CM \
	libcutils \
	libhardware \
	libbinder \
	android.hidl.token@1.0-utils \
	android.hardware.graphics.bufferqueue@2.0        

LOCAL_CFLAGS := \
	-DLOG_TAG=\"librga\"

ifneq ($(strip $(TARGET_BOARD_PLATFORM)),rk3368)
LOCAL_SHARED_LIBRARIES += libgralloc_drm 
endif

#ifneq (1,$(strip $(shell expr $(PLATFORM_VERSION) \< 6.9)))
LOCAL_CFLAGS += -DANDROID_7_DRM
LOCAL_CFLAGS += -DRK_DRM_GRALLOC=1
#endif

#ifneq (1,$(strip $(shell expr $(PLATFORM_VERSION) \< 8.0)))
LOCAL_CFLAGS += -DANDROID_8
#endif

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := $(TARGET_SHLIB_SUFFIX)

include $(BUILD_SHARED_LIBRARY)
endif
