vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO emberdawn-game/emberdawn-irrlicht
        REF "1.9.0-alpha.3"
        SHA512 c3baf3e8cf56c3caee08a7653536ded7825e3398b2a0d76f91b245a07aa8ed2e48f61276e8142fe009512e67d712557e05b03f94651bbf089a38c9350ecda07e
        HEAD_REF main
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -DBUILD_EXAMPLES=false)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/emberdawn-irrlicht)

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
