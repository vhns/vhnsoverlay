# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION='Second installment of the Twitch chat client series "Chatterino"'
HOMEPAGE="https://chatterino.com"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Chatterino/chatterino2"
else
	SRC_REPO_URI="https://github.com/Chatterino/chatterino2/archive/refs/tags/${PV}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT"
SLOT="0"

IUSE="streamlink pulseaudio gst-plugins-good dbus system-libcommuni system-qtkeychain"


RDEPEND="
	dev-qt/qtmultimedia
	dev-qt/qtconcurrent
	dev-qt/linguist-tools
	dev-qt/qtcore
	dev-libs/boost
	dev-libs/openssl
	streamlink? ( net-misc/streamlink )
	pulseaudio? ( media-libs/pulseaudio-qt )
	gst-plugins-good? ( media-libs/gst-plugins-good )
	dbus? ( sys-apps/dbus )
	system-libcommuni? ( net-im/libcommuni )
	system-qtkeychain? ( dev-libs/qtkeychain )
	"

BDEPEND="dev-util/cmake dev-vcs/git dev-qt/qtsvg ${DEPEND}"
DEPEND="${DEPEND}"

CMAKE_MAKEFILE_GENERATOR=emake

pkg_pretend(){
	if use dbus && use system-qtkeychain; then
		eerror "systemd-qtkeychain and -dbus are mutually exclusive"
		die
	fi
}

src_prepare(){
	use dbus || eapply  "${FILESDIR}/0001-Allow-for-building-without-QtKeychain.patch"
	eapply_user
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
				$(if ! use dbus; then
					echo "-DBUILD_WITH_QT_KEYCHAIN=0"
				fi)
				$(if use system-libcommuni; then
					echo "-DUSE_SYSTEM_LIBCOMMUNI=1"
				fi)
				$(if use system-qtkeychain; then
					echo "-DUSE_SYSTEM_QTKEYCHAIN=1"
				fi)
			)
	cmake_src_configure
}
