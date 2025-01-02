function main(package)
    os.cd(package:sourcedir())
    local mode = package:config("debug") and "build/Debug" or "build/Realease"
    if os.isdir(mode) then 
        return
    end
    print("is_shared = ",package:config("shared"))
    print("is_debug = ",package:config("debug"))
    print("begin build--------")
    local configs = {"-DMI_OVERRIDE=OFF"}
    table.insert(configs, "-DMI_BUILD_STATIC=" .. (package:config("shared") and "OFF" or "ON"))
    table.insert(configs, "-DMI_BUILD_SHARED=" .. (package:config("shared") and "ON" or "OFF"))
    --table.insert(configs, "-DMI_TRACK_ETW=" .. (package:config("debug") and "ON" or "OFF"))
    table.insert(configs, "-DMI_SECURE=" .. (package:config("secure") and "ON" or "OFF"))
    table.insert(configs, "-DMI_BUILD_TESTS=OFF")
    table.insert(configs, "-DMI_BUILD_OBJECT=OFF")
    -- 使用 CMake 从源码构建 mimalloc
    import("package.tools.cmake").build(package, configs,{buildir = "build"})
end