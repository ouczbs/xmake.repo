package("spirv-cross")

    set_homepage("https://www.lunarg.com/vulkan-sdk/")
    set_description("LunarG Vulkan® SDK")

    on_load(function (package)
        import("detect.sdks.find_vulkansdk")
        local vulkansdk = find_vulkansdk()
        if vulkansdk then
            package:addenv("PATH", vulkansdk.bindir)
        end
    end)

    on_fetch(function (package, opt)
        if opt.system then
            import("detect.sdks.find_vulkansdk")
            import("lib.detect.find_library")

            local vulkansdk = find_vulkansdk()
            if vulkansdk then
                local result = {includedirs = vulkansdk.includedirs, linkdirs = vulkansdk.linkdirs, links = {}}
                local utils = {"spirv-cross-glsl","spirv-cross-cpp", "spirv-cross-core", "spirv-cross-reflect","spirv-cross-util"}
                for _, util in ipairs(utils) do
                    if not find_library(util, vulkansdk.linkdirs) then
                        wprint(format("The library %s for %s is not found!", util, package:arch()))
                        return
                    end
                    table.insert(result.links, util)
                end
                return result
            end
        end
    end)
