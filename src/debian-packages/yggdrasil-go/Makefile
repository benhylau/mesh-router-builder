#
# Build and package yggdrasil-go
#

TAG = master

package_deb: package_deb_armhf package_deb_amd64

package_deb_armhf: build_bin_armhf
	cd /tmp/package_deb_armhf; cp yggdrasil yggdrasil_armhf.deb
	cp /tmp/package_deb_armhf/yggdrasil_armhf.deb /vagrant/output/

package_deb_amd64: build_bin_amd64
	cd /tmp/package_deb_amd64; cp yggdrasil yggdrasil_amd64.deb
	cp /tmp/package_deb_amd64/yggdrasil_amd64.deb /vagrant/output/

build_bin_armhf: download_source
	rm -rf /tmp/package_deb_armhf; mkdir /tmp/package_deb_armhf
	cd /tmp/yggdrasil-go; ./clean; GOARCH=arm GOARM=7 ./build; \
	  cp yggdrasil /tmp/package_deb_armhf/

build_bin_amd64: download_source
	rm -rf /tmp/package_deb_amd64; mkdir /tmp/package_deb_amd64
	cd /tmp/yggdrasil-go; ./clean; ./build; \
	  cp yggdrasil /tmp/package_deb_amd64/

download_source:
	rm -rf /tmp/yggdrasil-go
	git clone https://github.com/Arceliar/yggdrasil-go.git -b $(TAG) /tmp/yggdrasil-go

