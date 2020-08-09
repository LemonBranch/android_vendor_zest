/*
 * Copyright (c) 2018 The Android Open Source Project
 * Copyright (c) 2020 Zest Projects Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *		  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef POWER_LIBPERFMGR_POWER_H_
#define POWER_LIBPERFMGR_POWER_H_

#include <atomic>
#include <memory>
#include <thread>

#include <android/hardware/power/1.3/IPower.h>
#include <hidl/MQDescriptor.h>
#include <hidl/Status.h>
#include <perfmgr/HintManager.h>

#include "CameraMode.h"
#include "InteractionHandler.h"

namespace android
{
namespace hardware
{
namespace power
{
namespace V1_3
{
namespace implementation
{

using ::InteractionHandler;
using ::android::hardware::Return;
using ::android::hardware::Void;
using ::android::hardware::power::V1_0::Feature;
using ::android::hardware::power::V1_3::IPower;
using PowerHint_1_0 = ::android::hardware::power::V1_0::PowerHint;
using PowerHint_1_2 = ::android::hardware::power::V1_2::PowerHint;
using PowerHint_1_3 = ::android::hardware::power::V1_3::PowerHint;
using ::android::perfmgr::HintManager;

class Power : public IPower
{
	public:
		Power();

		//* Android Hardware Power 1.0 Methods
		Return<void> setInteractive(bool) override;
		Return<void> powerHint(PowerHint_1_0 hint, int32_t data) override;
		Return<void> setFeature(Feature feature, bool activate) override;
		Return<void>
		getPlatformLowPowerStats(getPlatformLowPowerStats_cb _hidl_cb) override;

		//* Android Hardware Power 1.1 Methods
		Return<void>
		getSubsystemLowPowerStats(getSubsystemLowPowerStats_cb _hidl_cb) override;
		Return<void> powerHintAsync(PowerHint_1_0 hint, int32_t data) override;

		//* Android Hardware Power 1.2 Methods
		Return<void> powerHintAsync_1_2(PowerHint_1_2 hint, int32_t data) override;

		//* Android Hardware Power 1.3 Methods
		Return<void> powerHintAsync_1_3(PowerHint_1_3 hint, int32_t data) override;

		//* Android HIDL Methods
		Return<void> debug(const hidl_handle &fd,
				   const hidl_vec<hidl_string> &args) override;

	private:
		std::shared_ptr<HintManager> mHintManager;
		std::unique_ptr<InteractionHandler> mInteractionHandler;
		std::atomic<bool> mVRModeOn;
		std::atomic<bool> mSustainedPerfModeOn;
		std::atomic<enum CameraStreamingMode> mCameraStreamingMode;
		std::atomic<bool> mReady;
		std::thread mInitThread;
};

} // namespace implementation
} // namespace V1_3
} // namespace power
} // namespace hardware
} // namespace android

#endif // POWER_LIBPERFMGR_POWER_H_
