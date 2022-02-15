vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO emberdawn-game/emberdawn-irrlicht
        REF "1.9.0-alpha.1"
        SHA512 34e1cd4686366eba35965ee83522cbb89740a04e5c5bb3e437e86727cfc192c91a84ca3d8f0bb43cdc1e4a0cda3e57f3e536d0a5b2ef7d3c79fae2a6256d4ab2
        HEAD_REF main
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -DBUILD_EXAMPLES=false)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/EmberdawnIrrlicht)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(MAKE_DIRECTORY "${CURRENT_PACKAGES}/debug/bin/")
file(GLOB debug_dlls "${CURRENT_PACKAGES_DIR}/debug/lib/*.dll")
foreach(debug_dll IN LISTS debug_dlls)
    file(RELATIVE_PATH debug_dll_rel "${CURRENT_PACKAGES_DIR}/debug/lib/" "${debug_dll}")
    file(RENAME "${debug_dll}" "${CURRENT_PACKAGES}/debug/bin/${debug_dll_rel}")
endforeach()

file(MAKE_DIRECTORY "${CURRENT_PACKAGES}/bin/")
file(GLOB release_dlls "${CURRENT_PACKAGES_DIR}/lib/*.dll")
foreach(release_dll IN LISTS release_dlls)
    file(RELATIVE_PATH release_dll_rel "${CURRENT_PACKAGES_DIR}/lib/" "${release_dll}")
    file(RENAME "${release_dll}" "${CURRENT_PACKAGES}/bin/${release_dll_rel}")
endforeach()
