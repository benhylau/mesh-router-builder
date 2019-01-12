#
# Build and package yggdrasil
#

PACKAGE_NAME = yggdrasil
VERSION = 0.3.2
DEBIAN_REVISION = 3
SOURCE_URL = https://github.com/yggdrasil-network/yggdrasil-go

TAG = v$(VERSION)
ARCHS = amd64 armhf
BUILD_DIR = /tmp/$(PACKAGE_NAME)
OUTPUT_DIR = ${BUILD_ARTIFACTS_DIR}/debian-packages

# Package deb for a particular architecture
#
# $1 is the architecture
define build_deb_arch
	# Use GitHub release version as deb_rev if set
	cd $(BUILD_DIR)/src; \
	  PKGARCH=$(1) sh contrib/deb/generate.sh; \
	  if test -n "${GITHUB_RELEASE_VERSION}"; \
	    then deb_rev=${GITHUB_RELEASE_VERSION}; \
	    else deb_rev=$(DEBIAN_REVISION); \
	  fi; \
	  cp unknown-$(VERSION)-$(1).deb $(OUTPUT_DIR)/$(PACKAGE_NAME)-$(VERSION)-$${deb_rev}_$(1).deb
endef

package_deb: download_source
	$(foreach arch,$(ARCHS),$(call build_deb_arch,$(arch));)

download_source: mkdir_build
	git clone $(SOURCE_URL).git $(BUILD_DIR)/src
	cd $(BUILD_DIR)/src; \
	  git checkout $(TAG)

mkdir_build:
	sudo rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)
	mkdir -p $(OUTPUT_DIR)
