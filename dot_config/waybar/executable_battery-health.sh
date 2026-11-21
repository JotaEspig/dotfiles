#!/usr/bin/env bash
# Emite JSON para o módulo custom/battery-health do waybar:
#   health mode ativo (carga limitada a ~80%) -> classe "limited" | desativado -> "full"
# Sem o driver acer-wmi-battery, não imprime nada (o módulo some).

f=/sys/bus/wmi/drivers/acer-wmi-battery/health_mode
[ -r "$f" ] || exit 0

if [ "$(<"$f")" = "1" ]; then
    printf '{"text":"%s","class":"limited","tooltip":"Carga limitada a ~80%%\\nClique para liberar 100%%"}\n' $'\U000F0565'
else
    printf '{"text":"%s","class":"full","tooltip":"Carga completa liberada\\nClique para limitar a ~80%%"}\n' $'\U000F0085'
fi
