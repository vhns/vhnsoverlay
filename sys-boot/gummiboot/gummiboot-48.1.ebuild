# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Simple EFI Boot Manager"
HOMEPAGE="https://pkgs.alpinelinux.org/package/edge/main/x86/gummiboot"
SRC_URI="https://dev.alpinelinux.org/archive/gummiboot/gummiboot-${PV}.tar.gz"

LICENSE="LGPL-2.0-or-later"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="sys-boot/gnu-efi app-arch/lzma dev-libs/libxslt"

PATCHES=(
	"${FILESDIR}/fix-glibc.patch"
)

inherit autotools

src_prepare() {
	eautoreconf
	default
}
