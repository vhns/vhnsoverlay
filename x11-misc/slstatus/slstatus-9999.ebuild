# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="slstatus is a status monitor for window managers \
that use WM_NAME or stdin to fill the status bar."
HOMEPAGE="http://tools.suckless.org/slstatus/"
EGIT_REPO_URI="https://git.suckless.org/slstatus"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"
BDEPEND=""

inherit git-r3 savedconfig

src_prepare(){
	default
	restore_config config.h
}

src_install(){
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	save_config config.h
}
