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
