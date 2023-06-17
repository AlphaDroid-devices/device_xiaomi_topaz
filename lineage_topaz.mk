#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from topaz device.
$(call inherit-product, device/xiaomi/topaz/device.mk)

# Device identifier
PRODUCT_NAME := lineage_topaz
PRODUCT_DEVICE := topaz
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 12 4G
PRODUCT_MANUFACTURER := Xiaomi

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
