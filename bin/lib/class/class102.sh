#!/usr/bin/env bash
# -- Tarea: trap, docker, nmap, openssl
#
# shellcheck disable=SC2154  # cblue is referenced but not

source "$(dirname "${BASH_SOURCE[0]}")/../../_shellutil.sh"

__usage(){
  local msg="$cblue
+==================+
| Piedritas: Tarea |
+==================+$cend

${cblue}End:$cend

  "

  echo -e "$msg"
}


get_fct_dic
call_fct_arg "$@"