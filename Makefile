# /home/norbert/sqlite3-android/Makefile
#
.DEFAULT_GOAL		:= build
SQLITE_AMALGATION	:= sqlite-amalgamation-3250300
SQLITE_SOURCEURL	:= https://sqlite.org/2018/$(SQLITE_AMALGATION).zip
# TARGET ABI := armeabi armeabi-v7a arm64-v8a x86 x86_64 mips mips64 (or all)
TARGET_ABI		:= armeabi-v7a arm64-v8a x86 x86_64
# URL_DOWNLOADER	:= wget -c
URL_DOWNLOADER		:= aria2c -q -c -x 3
CHECK_NDKPATH		:= $(shell which ndk-build >/dev/null 2>&1 ; echo $$?)


check-ndk-path:
ifneq ($(CHECK_NDKPATH), 0)
	$(error Cannot find ndk-build in $(PATH). Make sure Android NDK directory is included in your $$PATH variable)
endif

download: check-ndk-path
	@echo "===> Downloading file $(SQLITE_SOURCEURL)"
	@test ! -s "$(SQLITE_AMALGATION).zip" && \
		$(URL_DOWNLOADER) "$(SQLITE_SOURCEURL)" || \
		echo "===> File $(SQLITE_AMALGATION).zip already exists... skipping download."

unpack: download
	@echo "===> Unpacking $(SQLITE_AMALGATION).zip"
	@unzip -qo "$(SQLITE_AMALGATION).zip"
	@mv "$(SQLITE_AMALGATION)" build

build:	unpack
	@echo "===> Building $(SQLITE_AMALGATION)"
	@ndk-build NDK_DEBUG=0 APP_ABI="$(TARGET_ABI)"

clean:
	@echo "===> Cleaning up $(SQLITE_AMALGATION), build, libs, and obj directory"
	@rm -rf "$(SQLITE_AMALGATION)" build obj libs

clean-all: clean
	@echo "===> Deleting $(SQLITE_AMALGATION).zip"
	@rm -f "$(SQLITE_AMALGATION).zip"
