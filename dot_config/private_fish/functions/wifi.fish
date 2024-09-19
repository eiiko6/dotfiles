# Simplify wifi connection
function wifi
    if test (count $argv) -eq 0
        echo "usage: wifi <SSID> <password>"
    else
        nmcli device wifi connect "$argv[1]" password $argv[2]
    end
end
