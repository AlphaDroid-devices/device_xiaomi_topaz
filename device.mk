#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit virtual_ab_ota_product.
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/android_t_baseline.mk)
PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := gz

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Setup dalvik vm configs.
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Call the proprietary setup.
$(call inherit-product-if-exists, vendor/xiaomi/topaz/topaz-vendor.mk)

# MiuiCamera
TARGET_INCLUDES_MIUI_CAMERA := true
$(call inherit-product-if-exists, vendor/xiaomi/miuicamera/config.mk)

# Enable updating of APEXes.
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Project ID Quota.
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

DEVICE_PATH := device/xiaomi/topaz

# SHIPPING API
PRODUCT_SHIPPING_API_LEVEL := 31

# VNDK API
PRODUCT_TARGET_VNDK_VERSION := 32
PRODUCT_EXTRA_VNDK_VERSIONS := 30 31 32

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# Audio Configs
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_configuration.xml

# Bluetooth Audio (System-side HAL, sysbta)
PRODUCT_PACKAGES += \
    audio.sysbta.default \
    android.hardware.bluetooth.audio-service-system \
    libldacBT_abr \
    libldacBT_bco \
    libldacBT_enc

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service \
    bootctrl.xiaomi_bengal \
    bootctrl.xiaomi_bengal.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Boot Jars
PRODUCT_BOOT_JARS += \
    QPerformance \
    UxPerformance

# Dtb
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilts/dtb:dtb.img

# DT2W
PRODUCT_PACKAGES += \
    DT2W-Service-Topaz

# Fingerprint hal patched
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilts/libgf_hal.so.patched:$(TARGET_COPY_OUT_SYSTEM)/lib64/libgf_hal.so.patched

# FUSE passthrough
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Fix thermal QC
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/thermal/thermal-normal.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/thermal-normal.conf

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# F2FS utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Google Dialer Call recording
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/permissions/com.google.android.apps.dialer.call_recording_audio.features.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/com.google.android.apps.dialer.call_recording_audio.features.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl.recovery

# HotwordEnrollement
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/permissions/hotword-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/hotword-hiddenapi-package-whitelist.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

# Input
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/idc/uinput-fpc.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/uinput-fpc.idc \
    $(DEVICE_PATH)/configs/idc/uinput-goodix.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/uinput-goodix.idc \
    $(DEVICE_PATH)/configs/idc/uinput-fortsense.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/uinput-fortsense.idc \
    $(DEVICE_PATH)/configs/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-fpc.kl \
    $(DEVICE_PATH)/configs/keylayout/uinput-goodix.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-goodix.kl \
    $(DEVICE_PATH)/configs/keylayout/uinput-fortsense.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-fortsense.kl

# Lineage Health
PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

# NFC
PRODUCT_PACKAGES += \
    NfcNci \
    Tag \
    SecureElement \
    com.android.nfc_extras

# Overlays
PRODUCT_PACKAGES += \
    ApertureResTopaz \
    CarrierConfigResCommon \
    FrameworksResCommon \
    FrameworksResTopaz \
    SettingsOverlayM7G \
    SettingsOverlayM7N \
    SettingsOverlayM7L \
    SettingsOverlayM7IN \
    SettingsResCommon \
    SettingsResTopaz \
    SystemUIResCommon \
    SystemUIResTopaz \
    TelecommResCommon \
    SimpleDeviceConfig \
    TelephonyResCommon \
    TetheringResCommon \
    NotchBarKiller \
    SettingsLibCommon \
    BoostFrameworkOverlay \
    WifiOverlayTopaz

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
#PRODUCT_BUILD_SUPER_PARTITION := true

# Parts
PRODUCT_PACKAGES += \
    XiaomiParts

# Perf
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/permissions/com.qualcomm.qti.Performance.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/com.qualcomm.qti.Performance.xml \
    $(DEVICE_PATH)/configs/permissions/com.qualcomm.qti.UxPerformance.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/com.qualcomm.qti.UxPerformance.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service-qti

# Properties
include $(DEVICE_PATH)/configs/properties/default.mk

# RIL
PRODUCT_PACKAGES += \
    Ims \
    QtiTelephony \
    qti-telephony-common

# Perf
PRODUCT_PACKAGES += \
    vendor.qti.hardware.perf@2.3

# Rootdir
PRODUCT_PACKAGES += \
    init.recovery.qcom.rc \
    init.qcom.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    hardware/xiaomi

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
WITH_DEXPREOPT_DEBUG_INFO := false
DONT_DEXPREOPT_PREBUILTS := true

PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true

# Telephony
PRODUCT_PACKAGES += \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper.xml \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti-telephony-utils-prd \
    qti_telephony_utils.xml \
    qti_telephony_utils_prd.xml \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0

# Update engine
PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client
