-- http://projects.haskell.org/xmobar/
-- install xmobar with these flags: --flags="with_alsa" --flags="with_mpd" --flags="with_xft"  OR --flags="all_extensions"
-- you can find weather location codes here: http://weather.noaa.gov/index.html

Config { font    = "xft:Dejavu Sans Mono:pixelsize=18:antialias=true:hinting=true"
       , additionalFonts = [ "xft:FontAwesome:pixelsize=9" ]
       , bgColor = "#000000"
       , fgColor = "#ffffff"
       , border = FullB
       , borderColor = "#3579a8"
       , position = TopW C 100
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , commands = [ Run Date "%a, %b %d %Y, %H:%M:%S" "date" 10
                    --, Run Network "wlp2s0" ["-t", "<icon=net_up_20.xpm/>up <rxbar> <icon=net_down_20.xpm/>dn <txbar>"] 10
                    , Run Cpu ["-t", "cpu <bar> (<total>%)","-H","50","--high","red"] 10
                    , Run Memory ["-t", "Mem: <usedratio>%"] 10
                    --, Run Battery ["-t" , "Batt: <acstatus>: <left>% - <timeleft>" "--", "-O", "AC", "-o", "Bat", "-h", "green", "-l", "red"] 50
                    , Run Battery ["-t", "Batt: <left>% chr: <acstatus>",
                            "--Low", "10",        -- units: %
                            "--High", "60",        -- units: %
                            "--low", "darkred",
                            "--normal", "darkorange",
                            "--high", "darkgreen"] 50
                    , Run Com "/bin/bash" ["-c", "~/.xmonad/get-volume.sh"]  "myvolume" 1
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=haskell_20.xpm/> <fc=#666666>|</fc> %UnsafeStdinReader% }{ <fc=#FFB86C>%cpu%</fc> <fc=#FF5555>%memory%</fc> %myvolume% <fc=#FFB86C>%battery%</fc> <icon=calendar-clock-icon_20.xpm/> <fc=#ffffff>%date%</fc> "
       }
