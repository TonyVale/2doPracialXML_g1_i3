#!/bin/bash

es_numero() {
    local valor="$1"
    if [[ "$valor" =~ ^-?[0-9]+$ ]]; then
        echo "es numero"
        return 0  # Es un número
    else
        echo "no es numero"
        return 1  # No es un número
    fi
}

es_numero_valido() {
    local valor="$1"
    echo "$valor" -ge 2013
    if es_numero "$valor" && [ "$valor" -ge 2013 ] && [ "$valor" -le 2024 ]; then
        echo "es numero valido"
        return 0  # Es un número
    else
        echo "No es numero valido"
        return 1  # No es un número
    fi
}


es_parametro_valido() {
    local valor="$1"
    case "$valor" in
        sc|xf|cw|go|mc)
            return 0  # Es un valor válido
            ;;
        *)
            return 1  # No es un valor válido
            ;;
    esac
}

if  es_numero_valido "$2" && es_parametro_valido "$1"; then
    if [ -d "./$1/$2" ]; then
        echo "Ruta de acceso ya creada."
        java "net.sf.saxon.Query ./nascar_data.xq param1=A param2=B" -o:"nascar_data.xml"
    else
        mkdir -p "./$1/$2"
        curl "https://api.sportradar.com/nascar-ot3/$1/$2/drivers/list.xml?api_key=zY4yZ4cOmu4puVLXSW9hb9xBJMOhcoLj9K17OrSy" -o "./$1/$2/driver_list.xml"
        curl "https://api.sportradar.com/nascar-ot3/$1/drivers/$2/drivers.xml?api_key=zY4yZ4cOmu4puVLXSW9hb9xBJMOhcoLj9K17OrSy" -o "./$1/$2/driver_standings.xml"
    fi
    
else
    echo "Parametros incorrectos"
fi