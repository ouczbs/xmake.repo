package("noesis")
    set_homepage("https://www.noesisengine.com/")
    set_description(" NoesisGUI software is a vector graphics rendering engine software used to display XAML user interfaces in real-time applications.")
    add_versions("3.2.6 ", "...")
    add_configs("copy", {description = "wheter copy lib to buildir", default = false, type = "boolean"})
    on_fetch(function(package, opt)
        local root = path.join(os.scriptdir(), "latest")
        local includedirs = {path.join(root, "Include")}
        local plat_dir = nil
        if is_plat("windows") then
            plat_dir = "windows_x86_64"
        elseif is_plat("android") then 
            plat_dir = "android" .. package:arch()
        end
        local linkdirs = {path.join(root, "Lib", plat_dir)}
        local links = {package:name()}
        return {
            includedirs = includedirs, linkdirs = linkdirs, links = links
        }
    end)