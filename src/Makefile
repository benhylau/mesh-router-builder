#
# Build all artifacts from each subdirectory and optionally publish
#

PACKAGES_DIR = debian-packages
IMAGES_DIR = mesh-orange-images

BUILT_PACKAGES_DIR = ${BUILD_ARTIFACTS_DIR}/debian-packages
BUILT_IMAGES_DIR = ${BUILD_ARTIFACTS_DIR}/mesh-orange-images
PUBLISH_DIR = /tmp/publish

build_images: build_packages
	$(MAKE) -C $(IMAGES_DIR)

build_packages:
	$(MAKE) -C $(PACKAGES_DIR)

publish: package
	go get -u github.com/tcnksm/ghr
	go/bin/ghr \
	  -username ${GITHUB_USERNAME} \
	  -repository ${GITHUB_REPOSITORY} \
	  -token ${GITHUB_TOKEN} \
	  "v${GITHUB_RELEASE_VERSION}" $(PUBLISH_DIR)

package:
	rm -rf $(PUBLISH_DIR)
	mkdir $(PUBLISH_DIR)
	cp $(BUILT_PACKAGES_DIR)/* $(PUBLISH_DIR)/
	cp $(BUILT_IMAGES_DIR)/* $(PUBLISH_DIR)/
