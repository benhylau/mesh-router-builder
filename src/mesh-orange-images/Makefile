#
# Build mesh-orange system image for each board
#

TAG = master
BUILD_DIR = /tmp/mesh-orange
OUTPUT_DIR = /vagrant/output/mesh-orange-images

BOARDS += raspberrypi2
#BOARDS += sun4i-a10-cubieboard
#BOARDS += sun7i-a20-bananapi
BOARDS += sun8i-h2-plus-orangepi-zero
#BOARDS += sun8i-h3-orangepi-lite
#BOARDS += sun8i-v3s-licheepi-zero

build_images: download_source
	$(MAKE) -C $(BUILD_DIR) build-depends
	$(foreach board,$(BOARDS),$(MAKE) -C $(BUILD_DIR) clean; $(MAKE) -C $(BUILD_DIR)/boards/$(board) image;)
	cp $(BUILD_DIR)/output/* $(OUTPUT_DIR)

download_source: mkdir_build
	git clone https://github.com/tomeshnet/mesh-orange.git -b $(TAG) $(BUILD_DIR)
	cp -r mesh-orange/* $(BUILD_DIR)

mkdir_build:
	sudo rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)
	mkdir -p $(OUTPUT_DIR)
