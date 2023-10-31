# Enable the white Posy's cursor in kde. You can also specify a size between 24, 30, 36 and 48 as a paremeter. Default is 24.
posy-cursor-white-kde size='24':
    #!/usr/bin/env bash
    set -euxo pipefail
    plasma-apply-cursortheme "Posys_cursor_Linux" --size {{size}}

# Enable the white Posy's cursor in kde. You can also specify a size between 24, 30, 36 and 48 as a paremeter. Default is 24.
posy-cursor-black-kde size='24':
    #!/usr/bin/env bash
    set -euxo pipefail
    plasma-apply-cursortheme "Posys_cursor_Linux_black" --size {{size}}
# Set the terminal font to terminus. bold can be "normal", "bold", or "crt-vga-bold". There are certain options that are incompatible with each other."
terminus-console-font size='24' style='bold':
    #!/usr/bin/bash
    set -exo pipefail
    case {{size}} in
    12)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v12n
            ;;
        bold)
            echo 'The 12 size font does not have bold variants.'
            ;;
        crt-vga-bold)
            echo 'The 12 size font does not have bold variants.'
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold", or "crt-vga-bold".'
            ;;
        esac
        ;;
    14)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v14n
            ;;
        bold)
            rpm-ostree kargs --append=vconsole.font=ter-v14b
            ;;
        crt-vga-bold)
            rpm-ostree kargs --append=vconsole.font=ter-v14v
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold", or "crt-vga-bold".'
            ;;
        esac
        ;;
    16)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v16n
            ;;
        bold)
            rpm-ostree kargs --append=vconsole.font=ter-v16b
            ;;
        crt-vga-bold)
            rpm-ostree kargs --append=vconsole.font=ter-v16v
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold", or "crt-vga-bold".'
            ;;
        esac
        ;;
    18)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v18n
            ;;
        bold)
            rpm-ostree kargs --append=vconsole.font=ter-v18b
            ;;
        crt-vga-bold)
            echo 'Invalid style, size 18 does not have a "crt-vga-bold" variant.'
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold".'
            ;;
        esac
        ;;
    20)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v20n
            ;;
        bold)
            rpm-ostree kargs --append=vconsole.font=ter-v20b
            ;;
        crt-vga-bold)
            echo 'Invalid style, size 20 does not have a "crt-vga-bold" variant.'
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold".'
            ;;
        esac
        ;;
    22)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v22n
            ;;
        bold)
            rpm-ostree kargs --append=vconsole.font=ter-v22b
            ;;
        crt-vga-bold)
            echo 'Invalid style, size 22 does not have a "crt-vga-bold" variant.'
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold".'
            ;;
        esac
        ;;
    24)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v24n
            ;;
        bold)
            rpm-ostree kargs --append=vconsole.font=ter-v24b
            ;;
        crt-vga-bold)
            echo 'Invalid style, size 24 does not have a "crt-vga-bold" variant.'
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold".'
            ;;
        esac
        ;;
    28)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v28n
            ;;
        bold)
            rpm-ostree kargs --append=vconsole.font=ter-v28b
            ;;
        crt-vga-bold)
            echo 'Invalid style, size 28 does not have a "crt-vga-bold" variant.'
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold".'
            ;;
        esac
        ;;
    32)
        case {{style}} in
        normal)
            rpm-ostree kargs --append=vconsole.font=ter-v32n
            ;;
        bold)
            rpm-ostree kargs --append=vconsole.font=ter-v32b
            ;;
        crt-vga-bold)
            echo 'Invalid style, size 32 does not have a "crt-vga-bold" variant.'
            ;;
        *)
            echo 'Invalid style. Must be "normal","bold".'
            ;;
        esac
        ;;
    *)
        echo 'Invalid size. Must be one of 12,14,16,18,20,22,24,28,32.'
    esac

