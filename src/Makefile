#
# Build all artifacts from each subdirectory
#

PACKAGES_DIR = debian-packages
IMAGES_DIR = mesh-orange-images

build_images: build_packages
	$(MAKE) -C $(IMAGES_DIR)

build_packages:
	$(MAKE) -C $(PACKAGES_DIR)
