#!/bin/sh

# Banner ASCII TRISOUT
cat <<'BANNER'
 ____        _   _                 
|  _ \ _   _| |_| |__   ___  _ __  
| |_) | | | | __| '_ \ / _ \| '_ \ 
|  __/| |_| | |_| | | | (_) | | | |
|_|    \__, |\__|_| |_|\___/|_| |_|
       |___/                                                                   
BANNER

###############################################################################
# System info (CPU, Python, pip)
###############################################################################

print_system_box() {
  cpu_model="" cpu_usage_pct=""
  python_ver="N/A" pip_ver="N/A"

  # CPU model (Linux)
  if [ -r /proc/cpuinfo ]; then
    cpu_model=$(grep -m1 'model name' /proc/cpuinfo 2>/dev/null | cut -d: -f2- | sed 's/^ *//')
  fi
  [ -z "$cpu_model" ] && cpu_model="Unknown CPU"

  # CPU usage (Linux) computed from /proc/stat delta
  if [ -r /proc/stat ]; then
    read -r _ u1 n1 s1 i1 w1 q1 sq1 st1 _ _ < /proc/stat
    sleep 0.3
    read -r _ u2 n2 s2 i2 w2 q2 sq2 st2 _ _ < /proc/stat
    total1=$((u1+n1+s1+i1+w1+q1+sq1+st1))
    total2=$((u2+n2+s2+i2+w2+q2+sq2+st2))
    diff_total=$((total2-total1))
    diff_idle=$(((i2+w2)-(i1+w1)))
    if [ "$diff_total" -gt 0 ]; then
      cpu_usage_pct=$(( (1000 * (diff_total - diff_idle) / diff_total + 5) / 10 ))
    fi
  fi
  [ -z "$cpu_usage_pct" ] && cpu_usage_pct="N/A" || cpu_usage_pct="${cpu_usage_pct}%"

  # Python & pip versions
  if command -v python3 >/dev/null 2>&1; then
    python_ver=$(python3 --version 2>&1 | awk '{print $2}' || echo N/A)
  elif command -v python >/dev/null 2>&1; then
    python_ver=$(python --version 2>&1 | awk '{print $2}' || echo N/A)
  fi
  if command -v pip >/dev/null 2>&1; then
    pip_ver=$(pip --version 2>/dev/null | awk '{print $2}' || echo N/A)
  fi

  # Prepare pretty box
  line_cpu_model="CPU Model : ${cpu_model}"
  line_cpu_usage="CPU Usage : ${cpu_usage_pct}"
  line_python="Python    : ${python_ver}"
  line_pip="pip       : ${pip_ver}"

  # Determine width (cap at 76) based only on content (no left '# ' prefix now)
  width=0
  max=0
  for l in "$line_cpu_model" "$line_cpu_usage" "$line_python" "$line_pip"; do
    [ ${#l} -gt $max ] && max=${#l}
  done
  [ $max -gt 76 ] && max=76
  width=$max

  border=$(printf '%*s' "$width" '' | tr ' ' '#')
  echo "$border"
  printf "%-${width}s\n" "$line_cpu_model"
  printf "%-${width}s\n" "$line_python"
  printf "%-${width}s\n" "$line_pip"
  echo "$border"
  echo
}

print_system_box

if [ -n "${START_COMMAND1}" ]; then 
    eval "${START_COMMAND1}"
fi
if [ -n "${START_COMMAND2}" ]; then
    eval "${START_COMMAND2}"
fi