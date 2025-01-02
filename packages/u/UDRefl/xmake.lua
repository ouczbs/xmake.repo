
local lua_xmake = [[
local kind = "%s"
add_rules("mode.debug", "mode.release")
set_arch("x64")
set_languages("cxx20")
add_requires("UTemplate","USmallFlat")
target("UDRefl")
    set_kind(kind)
    add_packages("UTemplate","USmallFlat")
    add_includedirs("include")
    add_files("src/core/**.cpp")
    add_headerfiles("include/**.hpp","include/**.h")
]]
package("UDRefl")
    set_urls("https://github.com/Ubpa/UDRefl.git")
    add_includedirs("include")
    add_deps("UTemplate","USmallFlat")
    on_install("macosx", "linux", "windows", function (package)
        io.writefile("xmake.lua", format(lua_xmake,"static"))
        --local configs = {kind = "static"}
        package:config_set("debug",true)
        os.cp("include", package:installdir())
        import("package.tools.xmake").install(package)
        --import("package.tools.xmake").install(package)
    end)
