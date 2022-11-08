#
# k2htpmdtor for K2HASH MULTI TRANSACTION PLUGIN.
#
# Utility tools for building configure/packages by AntPickax
#
# Copyright 2020 Yahoo Japan Corporation.
#
# AntPickax provides utility tools for supporting autotools
# builds.
#
# These tools retrieve the necessary information from the
# repository and appropriately set the setting values of
# configure, Makefile, spec,etc file and so on.
# These tools were recreated to reduce the number of fixes and
# reduce the workload of developers when there is a change in
# the project configuration.
# 
# For the full copyright and license information, please view
# the license file that was distributed with this source code.
#
# AUTHOR:   Takeshi Nakatani
# CREATE:   Fri, Nov 13 2020
# REVISION:	1.1
#

#===============================================================
# Configuration for build_helper.sh
#===============================================================
# This file is loaded into the build_helper.sh script.
# The build_helper.sh script is a Github Actions helper script that
# builds and packages the target repository.
# This file is mainly created to define variables that differ depending
# on the OS and version.
# It also contains different information(such as packages to install)
# for each repository.
#
# In the initial state, you need to set the following variables:
#   DIST_TAG          : "Distro/Version" for publishing packages
#   INSTALL_PKG_LIST  : A list of packages to be installed for build and
#                       packaging
#   CONFIGURE_EXT_OPT : Options to specify when running configure
#   INSTALLER_BIN     : Package management command
#   PKG_OUTPUT_DIR    : Set the directory path where the package will
#                       be created relative to the top directory of the
#                       source
#   PKG_EXT           : The extension of the package file
#   IS_OS_UBUNTU      : Set to 1 for Ubuntu, 0 otherwise
#   IS_OS_DEBIAN      : Set to 1 for Debian, 0 otherwise
#   IS_OS_CENTOS      : Set to 1 for CentOS, 0 otherwise
#   IS_OS_FEDORA      : Set to 1 for Fedora, 0 otherwise
#   IS_OS_ROCKY       : Set to 1 for Rocky, 0 otherwise
#   IS_OS_ALPINE      : Set to 1 for Alpine, 0 otherwise
#
# Set these variables according to the CI_OSTYPE variable.
# The value of the CI_OSTYPE variable matches the name of the
# Container (docker image) used in Github Actions.
# Check the ".github/workflow/***.yml" file for the value.
#

#----------------------------------------------------------
# Default values
#----------------------------------------------------------
DIST_TAG=""
INSTALL_PKG_LIST=""
CONFIGURE_EXT_OPT=""
INSTALLER_BIN=""
PKG_OUTPUT_DIR=""
PKG_EXT=""

IS_OS_UBUNTU=0
IS_OS_DEBIAN=0
IS_OS_CENTOS=0
IS_OS_FEDORA=0
IS_OS_ROCKY=0
IS_OS_ALPINE=0

#----------------------------------------------------------
# Variables for each OS Type
#----------------------------------------------------------
if [ -z "${CI_OSTYPE}" ]; then
	#
	# Unknown OS : Nothing to do
	#
	:
elif [ "${CI_OSTYPE}" = "ubuntu:22.04" ] || [ "${CI_OSTYPE}" = "ubuntu:jammy" ]; then
	DIST_TAG="ubuntu/jammy"
	INSTALL_PKG_LIST="git autoconf autotools-dev gcc g++ make gdb dh-make fakeroot dpkg-dev devscripts libtool pkg-config ruby-dev rubygems procps rubygems-integration libyaml-dev chmpx-dev gnutls-dev"
	INSTALLER_BIN="apt-get"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="debian_build"
	PKG_EXT="deb"
	IS_OS_UBUNTU=1

elif [ "${CI_OSTYPE}" = "ubuntu:20.04" ] || [ "${CI_OSTYPE}" = "ubuntu:focal" ]; then
	DIST_TAG="ubuntu/focal"
	INSTALL_PKG_LIST="git autoconf autotools-dev gcc g++ make gdb dh-make fakeroot dpkg-dev devscripts libtool pkg-config ruby-dev rubygems procps rubygems-integration libyaml-dev chmpx-dev gnutls-dev"
	INSTALLER_BIN="apt-get"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="debian_build"
	PKG_EXT="deb"
	IS_OS_UBUNTU=1

elif [ "${CI_OSTYPE}" = "ubuntu:18.04" ] || [ "${CI_OSTYPE}" = "ubuntu:bionic" ]; then
	DIST_TAG="ubuntu/bionic"
	INSTALL_PKG_LIST="git autoconf autotools-dev gcc g++ make gdb dh-make fakeroot dpkg-dev devscripts libtool pkg-config ruby-dev rubygems procps rubygems-integration libyaml-dev chmpx-dev gnutls-dev"
	INSTALLER_BIN="apt-get"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="debian_build"
	PKG_EXT="deb"
	IS_OS_UBUNTU=1

elif [ "${CI_OSTYPE}" = "debian:11" ] || [ "${CI_OSTYPE}" = "debian:bullseye" ]; then
	DIST_TAG="debian/bullseye"
	INSTALL_PKG_LIST="git autoconf autotools-dev gcc g++ make gdb dh-make fakeroot dpkg-dev devscripts libtool pkg-config ruby-dev rubygems procps rubygems-integration libyaml-dev chmpx-dev gnutls-dev"
	INSTALLER_BIN="apt-get"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="debian_build"
	PKG_EXT="deb"
	IS_OS_DEBIAN=1

elif [ "${CI_OSTYPE}" = "debian:10" ] || [ "${CI_OSTYPE}" = "debian:buster" ]; then
	DIST_TAG="debian/buster"
	INSTALL_PKG_LIST="git autoconf autotools-dev gcc g++ make gdb dh-make fakeroot dpkg-dev devscripts libtool pkg-config ruby-dev rubygems procps rubygems-integration libyaml-dev chmpx-dev gnutls-dev"
	INSTALLER_BIN="apt-get"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="debian_build"
	PKG_EXT="deb"
	IS_OS_DEBIAN=1

elif [ "${CI_OSTYPE}" = "rockylinux:9.0" ] || [ "${CI_OSTYPE}" = "rockylinux:9" ]; then
	DIST_TAG="el/9"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps libyaml-devel chmpx-devel nss-devel"
	INSTALLER_BIN="dnf"
	INSTALL_QUIET_ARG="-q"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_ROCKY=1

elif [ "${CI_OSTYPE}" = "rockylinux:8.6" ] || [ "${CI_OSTYPE}" = "rockylinux:8" ]; then
	DIST_TAG="el/8"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps libyaml-devel chmpx-devel nss-devel"
	INSTALLER_BIN="dnf"
	INSTALL_QUIET_ARG="-q"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_ROCKY=1

elif [ "${CI_OSTYPE}" = "centos:7" ] || [ "${CI_OSTYPE}" = "centos:centos7" ]; then
	DIST_TAG="el/7"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps libyaml-devel chmpx-devel nss-devel"
	INSTALLER_BIN="yum"
	INSTALL_QUIET_ARG="-q"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_CENTOS=1

elif [ "${CI_OSTYPE}" = "fedora:36" ]; then
	DIST_TAG="fedora/36"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps libyaml-devel chmpx-devel nss-devel"
	INSTALLER_BIN="dnf"
	INSTALL_QUIET_ARG="-q"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_FEDORA=1

elif [ "${CI_OSTYPE}" = "fedora:35" ]; then
	DIST_TAG="fedora/35"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps libyaml-devel chmpx-devel nss-devel"
	INSTALLER_BIN="dnf"
	INSTALL_QUIET_ARG="-q"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_FEDORA=1

#
# [NOTICE]
# The OS from here onwards will be used until a new version is created, but we will drop support for it soon.
# Newer versions will only support the OSes mentioned before this line.
#
elif [ "${CI_OSTYPE}" = "ubuntu:16.04" ] || [ "${CI_OSTYPE}" = "ubuntu:xenial" ]; then
	DIST_TAG="ubuntu/xenial"
	INSTALL_PKG_LIST="git autoconf autotools-dev gcc g++ make gdb dh-make fakeroot dpkg-dev devscripts libtool pkg-config ruby-dev rubygems procps rubygems-integration libyaml-dev chmpx-dev gnutls-dev"
	INSTALLER_BIN="apt-get"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="debian_build"
	PKG_EXT="deb"
	IS_OS_UBUNTU=1

elif [ "${CI_OSTYPE}" = "debian:9" ] || [ "${CI_OSTYPE}" = "debian:stretch" ]; then
	DIST_TAG="debian/stretch"
	INSTALL_PKG_LIST="git autoconf autotools-dev gcc g++ make gdb dh-make fakeroot dpkg-dev devscripts libtool pkg-config ruby-dev rubygems procps rubygems-integration libyaml-dev chmpx-dev gnutls-dev"
	INSTALLER_BIN="apt-get"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="debian_build"
	PKG_EXT="deb"
	IS_OS_DEBIAN=1

elif [ "${CI_OSTYPE}" = "centos:8" ] || [ "${CI_OSTYPE}" = "centos:centos8" ]; then
	DIST_TAG="el/8"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps chmpx-devel nss-devel"
	INSTALLER_BIN="dnf"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_CENTOS=1

	#
	# Change mirrorlist
	#
	sed -i -e 's|^mirrorlist|#mirrorlist|g' -e 's|^#baseurl=http://mirror|baseurl=http://vault|g' /etc/yum.repos.d/CentOS-*repo

	# [NOTE]
	# For CentOS8, installing libyaml-devel from PowerTools( PwoerTools -> powertools at 2020/12 )
	#
	dnf update -y -qq
	dnf --enablerepo=powertools install -y libyaml-devel

elif [ "${CI_OSTYPE}" = "fedora:32" ]; then
	DIST_TAG="fedora/32"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps libyaml-devel chmpx-devel nss-devel"
	INSTALLER_BIN="dnf"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_FEDORA=1

elif [ "${CI_OSTYPE}" = "fedora:31" ]; then
	DIST_TAG="fedora/31"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps libyaml-devel chmpx-devel nss-devel"
	INSTALLER_BIN="dnf"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_FEDORA=1

elif [ "${CI_OSTYPE}" = "fedora:30" ]; then
	DIST_TAG="fedora/30"
	INSTALL_PKG_LIST="git autoconf automake gcc gcc-c++ gdb make libtool pkgconfig redhat-rpm-config rpm-build ruby-devel rubygems procps libyaml-devel chmpx-devel nss-devel"
	INSTALLER_BIN="dnf"
	INSTALL_QUIET_ARG="-qq"
	PKG_OUTPUT_DIR="."
	PKG_EXT="rpm"
	IS_OS_FEDORA=1
fi

#---------------------------------------------------------------
# Enable/Disable processing
#---------------------------------------------------------------
# [NOTE]
# Specify the phase of processing to use.
# The phases that can be specified are the following values, and
# the default is set for C/C++ processing.
# Setting this value to 1 enables the corresponding processing,
# setting it to 0 disables it.
#
#	<variable name>		<default value>
#	RUN_PRE_CONFIG			1
#	RUN_CONFIG				1
#	RUN_PRE_CLEANUP			0
#	RUN_CLEANUP				1
#	RUN_POST_CLEANUP		0
#	RUN_CPPCHECK			1
#	RUN_SHELLCHECK			1
#	RUN_CHECK_OTHER			0
#	RUN_PRE_BUILD			0
#	RUN_BUILD				1
#	RUN_POST_BUILD			0
#	RUN_PRE_TEST			0
#	RUN_TEST				1
#	RUN_POST_TEST			0
#	RUN_PRE_PACKAGE			0
#	RUN_PACKAGE				1
#	RUN_POST_PACKAGE		0
#	RUN_PUBLISH_PACKAGE		1
#
RUN_SHELLCHECK=0

#---------------------------------------------------------------
# Variables for each process
#---------------------------------------------------------------
# [NOTE]
# Specify the following variables that can be specified in each phase.
# Each value has a default value for C/C++ processing.
#
#	AUTOGEN_EXT_OPT_RPM				""
#	AUTOGEN_EXT_OPT_DEBIAN			""
#	AUTOGEN_EXT_OPT_ALPINE			""
#	AUTOGEN_EXT_OPT_OTHER			""
#
#	CONFIGURE_EXT_OPT_RPM			""
#	CONFIGURE_EXT_OPT_DEBIAN		""
#	CONFIGURE_EXT_OPT_ALPINE		""
#	CONFIGURE_EXT_OPT_OTHER			""
#
#	BUILD_MAKE_EXT_OPT_RPM			""
#	BUILD_MAKE_EXT_OPT_DEBIAN		""
#	BUILD_MAKE_EXT_OPT_ALPINE		""
#	BUILD_MAKE_EXT_OPT_OTHER		""
#
#	MAKE_TEST_OPT_RPM				"check"
#	MAKE_TEST_OPT_DEBIAN			"check"
#	MAKE_TEST_OPT_ALPINE			"check"
#	MAKE_TEST_OPT_OTHER				"check"
#
#	CREATE_PACKAGE_TOOL_RPM			"buildutils/rpm_build.sh"
#	CREATE_PACKAGE_TOOL_DEBIAN		"buildutils/debian_build.sh"
#	CREATE_PACKAGE_TOOL_ALPINE		"buildutils/apline_build.sh"
#	CREATE_PACKAGE_TOOL_OTHER		""
#
#	CREATE_PACKAGE_TOOL_OPT_AUTO	"-y"
#	CREATE_PACKAGE_TOOL_OPT_RPM		""
#	CREATE_PACKAGE_TOOL_OPT_DEBIAN	""
#	CREATE_PACKAGE_TOOL_OPT_ALPINE	""
#	CREATE_PACKAGE_TOOL_OPT_OTHER	""
#
if [ "${IS_OS_UBUNTU}" -eq 1 ] || [ "${IS_OS_DEBIAN}" -eq 1 ]; then
	CREATE_PACKAGE_TOOL_OPT_DEBIAN="--disttype ${DIST_TAG}"
fi

#
# Local variables:
# tab-width: 4
# c-basic-offset: 4
# End:
# vim600: noexpandtab sw=4 ts=4 fdm=marker
# vim<600: noexpandtab sw=4 ts=4
#
