# Enable the white Posy's cursor in kde. You can also specify a size between 24, 30, 36 and 48 as a paremeter. Default is 24.
posy-cursor-white-kde size='24':
    #!/usr/bin/env bash
    set -euxo pipefail
    plasma-apply-cursortheme "Posys_cursor_Linux" --size {{ size }}

# Enable the white Posy's cursor in kde. You can also specify a size between 24, 30, 36 and 48 as a paremeter. Default is 24.
posy-cursor-black-kde size='24':
    #!/usr/bin/env bash
    set -euxo pipefail
    plasma-apply-cursortheme "Posys_cursor_Linux_black" --size {{ size }}

# Set the terminal font to terminus. bold can be "normal", "bold", or "crt-vga-bold". There are certain options that are incompatible with each other."
terminus-console-font size='24' style='bold':
    #!/usr/bin/bash
    set -exo pipefail
    case {{ size }} in
    12)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v12n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v12n' /etc/vconsole.conf
            ;;
        bold)
            printf 'The 12 size font does not have bold variants.' >&2
            exit 1
            ;;
        crt-vga-bold)
            printf 'The 12 size font does not have bold variants.' >&2
            exit 1
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold", or "crt-vga-bold".' >&2
            exit 1
            ;;
        esac
        ;;
    14)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v14n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v14n' /etc/vconsole.conf
            ;;
        bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v14b
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v14b' /etc/vconsole.conf
            ;;
        crt-vga-bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v14v
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v14v' /etc/vconsole.conf
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold", or "crt-vga-bold".' >&2
            exit 1
            ;;
        esac
        ;;
    16)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v16n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v16n' /etc/vconsole.conf
            ;;
        bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v16b
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v16b' /etc/vconsole.conf
            ;;
        crt-vga-bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v16v
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v16v' /etc/vconsole.conf
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold", or "crt-vga-bold".' >&2
            exit 1
            ;;
        esac
        ;;
    18)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v18n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v18n' /etc/vconsole.conf
            ;;
        bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v18b
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v18b' /etc/vconsole.conf
            ;;
        crt-vga-bold)
            printf 'Invalid style, size 18 does not have a "crt-vga-bold" variant.' >&2
            exit 1
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold".' >&2
            exit 1
            ;;
        esac
        ;;
    20)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v20n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v20n' /etc/vconsole.conf
            ;;
        bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v20b
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v20b' /etc/vconsole.conf
            ;;
        crt-vga-bold)
            printf 'Invalid style, size 20 does not have a "crt-vga-bold" variant.' >&2
            exit 1
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold".' >&2
            exit 1
            ;;
        esac
        ;;
    22)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v22n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v22n' /etc/vconsole.conf
            ;;
        bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v22b
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v22b' /etc/vconsole.conf
            ;;
        crt-vga-bold)
            printf 'Invalid style, size 22 does not have a "crt-vga-bold" variant.' >&2
            exit 1
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold".' >&2
            exit 1
            ;;
        esac
        ;;
    24)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v24n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v24n' /etc/vconsole.conf
            ;;
        bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v24b
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v24b' /etc/vconsole.conf
            ;;
        crt-vga-bold)
            printf 'Invalid style, size 24 does not have a "crt-vga-bold" variant.' >&2
            exit 1
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold".' >&2
            exit 1
            ;;
        esac
        ;;
    28)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v28n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v28n' /etc/vconsole.conf
            ;;
        bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v28b
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v28b' /etc/vconsole.conf
            ;;
        crt-vga-bold)
            printf 'Invalid style, size 28 does not have a "crt-vga-bold" variant.' >&2
            exit 1
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold".' >&2
            exit 1
            ;;
        esac
        ;;
    32)
        case {{ style }} in
        normal)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v32n
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v32n' /etc/vconsole.conf
            ;;
        bold)
            rpm-ostree kargs --delete-if-present=vconsole.font
            rpm-ostree kargs --append=vconsole.font=ter-v32b
            sudo sed -nri '/^FONT=/!p;$aFONT=ter-v32b' /etc/vconsole.conf
            ;;
        crt-vga-bold)
            printf 'Invalid style, size 32 does not have a "crt-vga-bold" variant.' >&2
            exit 1
            ;;
        *)
            printf 'Invalid style. Must be "normal","bold".' >&2
            exit 1
            ;;
        esac
        ;;
    *)
        printf 'Invalid size. Must be one of 12,14,16,18,20,22,24,28,32.' >&2
            exit 1
    esac

    if rpm-ostree initramfs | grep -q disabled; then
        rpm-ostree initramfs --enable
    fi
