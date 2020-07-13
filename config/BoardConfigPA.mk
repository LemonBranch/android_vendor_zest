# Kernel
include vendor/zest/config/BoardConfigKernel.mk

# QCOM flags
ifeq ($(call is-vendor-board-platform,QCOM),true)
include vendor/zest/config/BoardConfigQcom.mk
endif

# Soong
include vendor/zest/config/BoardConfigSoong.mk
