-- Hyprland config (Lua) — migrado de hyprland.conf (hyprlang) para o novo
-- formato Lua introduzido no Hyprland 0.55.
-- https://wiki.hypr.land/Configuring/Start/


------------------
---- MONITORS ----
------------------

-- https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ output = "",       mode = "preferred", position = "auto", scale = 1.0 })
hl.monitor({ output = "eDP-1",  mode = "preferred", position = "auto", scale = 1.0 })


---------------------
---- MY PROGRAMS ----
---------------------

local terminal      = "kitty"
local browser       = "brave"
local fileManager   = "nautilus"
local menu          = "rofi -show drun"
local wallpaperPath = "~/.config/hypr/wallpapers"


-------------------
---- AUTOSTART ----
-------------------

-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    -- hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")
    -- o daemon precisa subir antes do "awww img", senão o wallpaper falha
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("sleep 1 && awww img " .. wallpaperPath .. "/$(head -n 1 " .. wallpaperPath .. "/current.set) --resize crop")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
    hl.exec_cmd("wlsunset -S 05:30 -s 21:00 -T 5000 -t 3500")
    hl.exec_cmd("blueman-applet")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")


-----------------------
----- PERMISSIONS -----
-----------------------

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Visual "vidro fosco" (liquid glass leve): blur + borda com brilho + cantos suaves
hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = { top = 6, right = 6, bottom = 6, left = 6 }, -- topo menor: junto da waybar

        border_size = 1,

        col = {
            -- brilho de aresta: degradê claro na ativa, quase invisível na inativa
            active_border   = { colors = { "rgba(ffffff66)", "rgba(5FAFFF55)", "rgba(ffffff22)" }, angle = 45 },
            inactive_border = "rgba(ffffff14)",
        },

        resize_on_border = true,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 12,
        rounding_power = 4, -- cantos "squircle"

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        dim_inactive = true,
        dim_strength = 0.08,

        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            color        = 0x55000000,
        },

        blur = {
            enabled           = true,
            size              = 7,
            passes            = 2,
            new_optimizations = true,
            xray              = false,
            noise             = 0.015,
            contrast          = 1.0,
            brightness        = 1.05,
            vibrancy          = 0.2,
            vibrancy_darkness = 0.3,
            popups            = true,
        },
    },

    animations = {
        enabled = true,
    },

    debug = {
        vfr = true, -- só redesenha quando algo muda (economiza bateria)
    },

    cursor = {
        inactive_timeout = 3,
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}   } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}} })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })
hl.curve("overshoot",      { type = "bezier", points = { {0.34, 1.35}, {0.64, 1} } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 6,    bezier = "easeOutQuint" })
hl.animation({ leaf = "borderangle",   enabled = true, speed = 30,   bezier = "linear", style = "once" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.5,  bezier = "overshoot",    style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 2.5,  bezier = "easeOutQuint", style = "popin 85%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeDim",       enabled = true, speed = 4,    bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "overshoot",    style = "popin 90%" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 2.5,  bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 3,    bezier = "easeOutQuint", style = "slidefade 20%" })

-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only" — descomente se quiser usar
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 1, rounding = 0 })
hl.window_rule({ name = "no-gaps-f1",   match = { float = false, workspace = "f[1]" },   border_size = 1, rounding = 0 })

hl.config({
    dwindle = {
        preserve_split = true,
        split_bias     = 1,
        smart_resizing = false,
        force_split    = 2,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "intl",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0,

        touchpad = {
            natural_scroll        = true,
            disable_while_typing  = false,
        },
    },
})

-- Config por dispositivo: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
-- hl.device({ name = "<nome do dispositivo>", sensitivity = -0.5 })


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("~/.config/hypr/kitty-smart-launch.sh"))
hl.bind(mainMod .. " + C",      hl.dsp.window.close())
hl.bind(mainMod .. " + W",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit()) -- SHIFT evita sair da sessão sem querer
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + space",  hl.dsp.exec_cmd("~/.config/hypr/windowfloat.sh"))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Tab",         hl.dsp.window.cycle_next({ next = true }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + P",      hl.dsp.window.pin({ action = "toggle" }))
hl.bind(mainMod .. " + Print",       hl.dsp.exec_cmd("hyprshot -m output -m eDP-1 -o ~/Pictures/screenshots"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region --raw | satty --filename -"))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("hyprlock"))
-- Wallpaper picker
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/wallpaper-switch.sh pick"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Exemplo (desativado): https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- hl.window_rule({ name = "float-kitty", match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })

-- Translucidez só em apps leves (vidro aparece sem pesar em navegador/vídeo)
hl.window_rule({ name = "glass-kitty",   match = { class = "^(kitty)$" },              opacity = "0.92 0.85" })
hl.window_rule({ name = "glass-files",   match = { class = "^(org.gnome.Nautilus)$" }, opacity = "0.94 0.88" })

-- Diálogos comuns flutuam sozinhos
hl.window_rule({ name = "float-pavucontrol", match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })
hl.window_rule({ name = "float-blueman",     match = { class = "^(.blueman-manager-wrapped)$" },   float = true })

-- Camadas (barra, launcher, notificações) com o mesmo vidro
for _, ns in ipairs({ "waybar", "rofi", "swaync-control-center", "swaync-notification-window" }) do
    hl.layer_rule({ name = "glass-" .. ns, match = { namespace = ns }, blur = true, ignore_alpha = 0.3 })
end

-- Gesto de 3 dedos no touchpad troca de workspace
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
