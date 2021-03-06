#! /usr/bin/env bash

function __print_aospa_functions_help()
{
	cat <<EOF
Additional Lemon Branch functions:
- cout:            Changes directory to out.
- repopick:        Utility to fetch changes from Gerrit.
- gerritremote:    Add git remote for Lemon Branch Gerrit Review (CURRENTLY BROKEN).
- aospremote:      Add git remote for matching AOSP repository.
- cafremote:       Add git remote for matching CodeAurora repository.
- githubremote:    Add git remote for Lemon Branch Github.
- mka:             Builds using SCHED_BATCH on all processors.
- repolastsync:    Prints date and time of last repo sync.
EOF
}

function brunch()
{
	breakfast "$*"

# shellcheck disable=SC2181
	if [ $? -eq 0 ]; then
		mka bacon
	else
		echo "No such item in brunch menu. Try 'breakfast'"
		return 1
	fi

	return $?
}

function breakfast()
{
	target=$1
	local variant=$2

	if [ $# -eq 0 ]; then
		lunch
	else
		echo "z$target" | grep -q "-"

# shellcheck disable=SC2181
		if [ $? -eq 0 ]; then
			lunch "$target"
		
		else
			if [ -z "$variant" ]; then
				variant="userdebug"
			fi

			lunch "zest_$target-$variant"
		fi
	fi

	return $?
}

alias bib=breakfast

function cout()
{
	cd "$OUT" || echo "Couldn't locate out directory.  Try setting OUT."
}

function gerritremote()
{
	if ! git rev-parse --git-dir &>/dev/null; then
		echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
		return 1
	fi

	git remote rm aospagerrit 2>/dev/null

	REMOTE=$(git config --get remote.aospa.projectname)
	local REMOTE
	local AOSPA="true"

	if [ -z "$REMOTE" ]; then
		REMOTE=$(git config --get remote.aosp.projectname)
		AOSPA="false"
	fi

	if [ -z "$REMOTE" ]; then
		REMOTE=$(git config --get remote.caf.projectname)
		AOSPA="false"
	fi

	if [ $AOSPA = "false" ]; then
		PROJECT=$(echo "$REMOTE" | sed -e "s#platform/#android/#g; s#/#_#g")
		local PROJECT
		local PFX="AOSPA/"
	else
		local PROJECT=$REMOTE
	fi

	AOSPA_USER=$(git config --get review.gerrit.aospa.co.username)
	local AOSPA_USER

	if [ -z "$AOSPA_USER" ]; then
		git remote add aospagerrit "ssh://gerrit.aospa.co:29418/$PFX$PROJECT"
	else
		git remote add aospagerrit "ssh://$AOSPA_USER@gerrit.aospa.co:29418/$PFX$PROJECT"
	fi

	echo "Remote 'aospagerrit' created"
}

function aospremote()
{
	if ! git rev-parse --git-dir &>/dev/null; then
		echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
		return 1
	fi

	git remote rm aosp 2>/dev/null

	PROJECT=$(pwd -P | sed -e "s#$ANDROID_BUILD_TOP\/##; s#-caf.*##; s#\/default##")
	local PROJECT

	
	if [ "$PROJECT" = "build/make" ]; then
		PROJECT="build"
	fi

	if (echo $PROJECT | grep -qv "^device"); then
		local PFX="platform/"
	fi

	git remote add aosp "https://android.googlesource.com/$PFX$PROJECT"

	echo "Remote 'aosp' created"
}

function cafremote()
{
	if ! git rev-parse --git-dir &>/dev/null; then
		echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
		return 1
	fi

	git remote rm caf 2>/dev/null

	PROJECT=$(pwd -P | sed -e "s#$ANDROID_BUILD_TOP\/##; s#-caf.*##; s#\/default##")
	local PROJECT

	if [ "$PROJECT" = "build/make" ]; then
		PROJECT="build"
	fi

	if [[ $PROJECT =~ "qcom/opensource" ]]; then
# shellcheck disable=SC2001
		PROJECT=$(echo $PROJECT | sed -e "s#qcom\/opensource#qcom-opensource#")
	fi

	if (echo "$PROJECT" | grep -qv "^device"); then
		local PFX="platform/"
	fi

	git remote add caf "https://source.codeaurora.org/quic/la/$PFX$PROJECT"

	echo "Remote 'caf' created"
}

function githubremote()
{
	if ! git rev-parse --git-dir &>/dev/null; then
		echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
		return 1
	fi

	git remote rm aospa 2>/dev/null

	REMOTE=$(git config --get remote.caf.projectname)
	local REMOTE

	if [ -z "$REMOTE" ]; then
		REMOTE=$(git config --get remote.aospa.projectname)
	fi

	PROJECT=$(echo "$REMOTE" | sed -e "s#platform/#android/#g; s#/#_#g")
	local PROJECT

	if [[ $PROJECT =~ "qcom-opensource" ]]; then
# shellcheck disable=SC2001
		PROJECT=$(echo "$PROJECT" | sed -e "s#qcom-opensource#qcom_opensource#")
	fi

	git remote add aospa "https://github.com/AOSPA/$PROJECT"

	echo "Remote 'aospa' created"
}

function mka()
{
	if [ -f "$ANDROID_BUILD_TOP/$QTI_BUILDTOOLS_DIR/build/update-vendor-hal-makefiles.sh" ]; then
		vendor_hal_script=$ANDROID_BUILD_TOP/$QTI_BUILDTOOLS_DIR/build/update-vendor-hal-makefiles.sh
# shellcheck disable=SC1090
		source "$vendor_hal_script" --check
		regen_needed=$?
	else
		vendor_hal_script=$ANDROID_BUILD_TOP/device/qcom/common/vendor_hal_makefile_generator.sh
		regen_needed=1
	fi

	if [ $regen_needed -eq 1 ]; then
		_wrap_build "$(get_make_command hidl-gen)" hidl-gen ALLOW_MISSING_DEPENDENCIES=true

# shellcheck disable=SC2181
		if [ $? -ne 0 ]; then
# shellcheck disable=SC2154
			echo -n "${color_failed}#### hidl-gen compilation failed, check above errors"
# shellcheck disable=SC2154
			echo " ####${color_reset}"
			return $?
		fi
		
# shellcheck disable=SC1090		
		source "$vendor_hal_script"

# shellcheck disable=SC2181
		if [ $? -ne 0 ]; then
			echo -n "${color_failed}#### HAL file .bp generation failed dure to incpomaptible HAL files , please check above error log"
			echo " ####${color_reset}"
			return $?
		fi
	fi

	m -j "$@"
}

function repolastsync()
{
	RLSPATH="$ANDROID_BUILD_TOP/.repo/.repo_fetchtimes.json"
	RLSLOCAL=$(date -d "$(stat -c %z $RLSPATH)" +"%e %b %Y, %T %Z")
	RLSUTC=$(date -d "$(stat -c %z $RLSPATH)" -u +"%e %b %Y, %T %Z")
	echo "Last repo sync: $RLSLOCAL / $RLSUTC"
}

function repopick()
{
	T=$(gettop)
	"$T/vendor/zest/build/tools/repopick.py" "$@"
}
