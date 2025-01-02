local lua_xmake = [[
local kind = "%s"
add_requires("lua")
target("lua-protobuf")
    set_kind(kind)
    add_packages("lua")
    add_files("*.c")
    add_headerfiles("*.h")
]]
package("lua-protobuf")
    set_urls("https://github.com/starwing/lua-protobuf.git")
    add_includedirs("include")
    on_install("macosx", "linux", "windows", function (package)
        io.writefile("xmake.lua", format(lua_xmake,"static"))
        local configs = {kind = "static"}
        import("package.tools.xmake").install(package, configs)
    end)