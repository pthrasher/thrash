# Set global color styles, for example:
#
# function thrasher_error
#   set_color -o red
# end
#
# function thrasher_normal
#   set_color normal
#

set -e fish_greeting
if status --is-interactive
    function fish_greeting
        fortune
    end
end
