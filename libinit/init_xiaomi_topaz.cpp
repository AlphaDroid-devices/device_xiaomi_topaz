/*
 * Copyright (C) 2021-2022 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_dalvik_heap.h>
#include <libinit_variant.h>
#include <libinit_utils.h>

#include "vendor_init.h"

#define FINGERPRINT_M7N "Redmi/topaz_global/topaz:13/TKQ1.221114.001/V14.0.7.0.TMGMIXM:user/release-keys"
#define FINGERPRINT_M7G "Redmi/tapas_global/tapas:13/TKQ1.221114.001/V14.0.14.0.TMTMIXM:user/release-keys"

static const variant_info_t topaz_global_info = {
    .hwc_value = "Global",
    .sku_value = "m7n",

    .brand = "Xiaomi",
    .device = "topaz",
    .marketname = "Redmi Note 12 4G NFC",
    .model = "23021RAA2Y",
    .mod_device = "topaz_global",
    .build_fingerprint = FINGERPRINT_M7N,
};

static const variant_info_t tapas_global_info = {
    .hwc_value = "Global",
    .sku_value = "m7g",

    .brand = "Xiaomi",
    .device = "tapas",
    .marketname = "Redmi Note 12 4G",
    .model = "23021RAAEG",
    .mod_device = "tapas_global",
    .build_fingerprint = FINGERPRINT_M7G,
};

static const std::vector<variant_info_t> variants = {
    topaz_global_info,
    tapas_global_info,
};

void vendor_load_properties() {
    set_dalvik_heap();
    search_variant(variants);

    // SafetyNet workaround
    property_override("ro.boot.verifiedbootstate", "green");
}
