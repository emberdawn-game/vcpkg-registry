vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO emberdawn-game/emberdawn-irrlicht
        REF "1.9.0-alpha.4"
        SHA512 c171d265f53527cc5b65006ff531f1c2c2a25184b542650e7385fcdfde08f2906cfad0b7be689e605c20d2eb20bef10dcf86b5f2b91e6e588a0445a9299b75f7
        HEAD_REF main
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -DBUILD_EXAMPLES=false)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH share/cmake/emberdawn-irrlicht)

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
