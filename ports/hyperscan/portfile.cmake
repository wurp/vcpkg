# Build with 'vcpkg.exe install hyperscan:x86-windows-static-release'; Hyperscan doesn't support dynamic libraries on Windows.
include(vcpkg_common_functions)

set(HYPERSCAN_VERSION 5.1.1)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/wurp/hyperscan/archive/master.zip"
    FILENAME "v${HYPERSCAN_VERSION}.zip"
    SHA512 03123662630af0311100aa7b13700c6481b96b808f0211084088dfef2f1f11855efe061e5246cc176e86b6b31a0d636b8daebc5bafb1af5544470b4c269785cc
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${HYPERSCAN_VERSION})

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/mcclellancompile.patch"
            "${CMAKE_CURRENT_LIST_DIR}/ue2string.patch"
)

vcpkg_find_acquire_program(PYTHON3)

# Add python3 to path
get_filename_component(PYTHON_PATH ${PYTHON3} DIRECTORY)
vcpkg_add_to_path(PREPEND ${PYTHON_PATH})
vcpkg_add_to_path(${CURRENT_INSTALLED_DIR}/bin)
vcpkg_add_to_path(${CURRENT_INSTALLED_DIR}/debug/bin)
vcpkg_find_acquire_program(PYTHON3)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/hyperscan RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME hs)
