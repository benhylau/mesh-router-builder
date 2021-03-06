#
# Build mesh-orange system image for each board
#

# Use default node profile if PROFILE variable is not passed
PROFILE ?= default

TAG = master
BUILD_DIR = /tmp/mesh-orange
OUTPUT_DIR = ${BUILD_ARTIFACTS_DIR}/mesh-orange-images

# raspberrypi3 is automatically generated when raspberrypi2 is enabled because they share the same image
BOARDS += raspberrypi2
#BOARDS += sun4i-a10-cubieboard
#BOARDS += sun7i-a20-bananapi
BOARDS += sun8i-h2-plus-orangepi-zero
#BOARDS += sun8i-h3-orangepi-lite
#BOARDS += sun8i-v3s-licheepi-zero

build_images: download_source
	$(MAKE) -C $(BUILD_DIR) build-depends
	$(foreach board,$(BOARDS),$(MAKE) -C $(BUILD_DIR) clean; $(MAKE) -C $(BUILD_DIR)/boards/$(board) image;)
	if test -n "${GITHUB_RELEASE_VERSION}"; \
	    then rename "s/.img/-${GITHUB_RELEASE_VERSION}_$(PROFILE).img/" $(BUILD_DIR)/output/*.img; \
	    else rename "s/.img/-$(PROFILE).img/" $(BUILD_DIR)/output/*.img; \
	  fi
	cp $(BUILD_DIR)/output/* $(OUTPUT_DIR)

download_source: mkdir_build
	git clone https://github.com/tomeshnet/mesh-orange.git -b $(TAG) $(BUILD_DIR)
	cp -r mesh-orange/$(PROFILE)/* $(BUILD_DIR)

mkdir_build: node_profile
	sudo rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)
	mkdir -p $(OUTPUT_DIR)

ifeq ($(PROFILE),default)

node_profile:
	@echo 'Building mesh-orange with the 'default' node profile...'
	@echo 'To build with a different node profile, pass the PROFILE flag:'
	@echo ''
	@echo '    $$ make PROFILE=custom-profile'
	@echo ''

else

node_profile:
	@echo "Building mesh-orange with the '$(PROFILE)' node profile..."

endif
