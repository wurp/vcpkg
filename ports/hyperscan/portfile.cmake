include(vcpkg_common_functions)

set(HYPERSCAN_VERSION 5.1.1)
vcpkg_download_distfile(ARCHIVE
    URLS "https://codeload.github.com/wurp/hyperscan/zip/v5.1.1"
    FILENAME "v${HYPERSCAN_VERSION}.zip"
    SHA512 50b22909613f4ce97a8b5551250f2dd8c1d0492250376ec56d19b6f153a3c46c72d3335f89d86b02c53f09e95d82be131b8ed6862cea9fe7260e1055007d2a94
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
