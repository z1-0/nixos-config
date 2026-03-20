{
  writeShellApplication,
  curl,
  jq,
  ...
}:
writeShellApplication {
  name = "ccr-ping";
  runtimeInputs = [
    jq
    curl
  ];

  text = ''
    CONFIG="''${1:-''$HOME/.claude-code-router/config.json}"

    if [[ ! -f "''${CONFIG}" ]]; then
      echo "Error: Config not found: ''${CONFIG}"
      exit 1
    fi

    # Preprocess: support full-line // comments only
    JSON_CLEAN=$(sed '/^[[:space:]]*\/\//d' "''${CONFIG}")

    # Validate
    if ! echo "''${JSON_CLEAN}" | jq empty 2>/dev/null; then
      echo "Error: Invalid JSON in ''${CONFIG}. Only full-line // comments are supported; trailing // comments are not allowed."
      exit 1
    fi

    PROXY=$(echo "''${JSON_CLEAN}" | jq -r '.PROXY_URL // ""' | xargs)

    printf "%-15s %-38s %12s    %-12s\n" "Provider" "Model" "TTFB" "Status"
    printf '%0.s-' {1..82}
    echo

    tmp_fails=$(mktemp)
    trap 'rm -f "''${tmp_fails}"' EXIT

    run_check() {
      local name="''${1}"
      local m="''${2}"
      local base="''${3}"
      local key="''${4}"
      local unsupported="''${5}"

      if [[ "''${unsupported}" == "1" ]]; then
        printf "%-15s %-38s %12s    %-12s\n" "''${name}" "''${m}" "-" "UNSUPPORTED"

        printf "%s\t%s\t%s\t%s\n" "''${name}" "''${m}" "UNSUPPORTED" "provider has transformer" >> "''${tmp_fails}"
        return 0
      fi

      local url data
      local -a headers curl_opts

      url="''${base}"
      data="{\"model\":\"''${m}\",\"messages\":[{\"role\":\"user\",\"content\":\"hi\"}],\"max_tokens\":1,\"stream\":true}"
      headers=(-H "Content-Type: application/json" -H "Authorization: Bearer ''${key}")

      curl_opts=(-s --max-time 15 -w "\n__META__%{time_starttransfer},%{http_code}")
      [[ -n "''${PROXY}" ]] && curl_opts+=(-x "''${PROXY}")

      local res meta body ttfb code snippet ttfb_ms ttfb_display
      res=$(curl "''${curl_opts[@]}" "''${headers[@]}" -d "''${data}" "''${url}" 2>/dev/null || true)

      meta=$(printf "%s" "''${res}" | tail -n 1)
      body=$(printf "%s" "''${res}" | sed '$d')

      if [[ "''${meta}" == __META__* ]]; then
        ttfb=$(printf "%s" "''${meta#__META__}" | cut -d, -f1)
        code=$(printf "%s" "''${meta#__META__}" | cut -d, -f2)
      else
        ttfb="0.000"
        code="000"
      fi

      ttfb_ms=$(awk -v s="''${ttfb}" 'BEGIN { printf "%.2f", s * 1000 }')
      ttfb_display="''${ttfb_ms}ms"

      if [[ "''${code}" =~ ^2[0-9][0-9]$ ]]; then
        printf "%-15s %-38s %12s    %-12s\n" "''${name}" "''${m}" "''${ttfb_display}" "OK"
      else
        printf "%-15s %-38s %12s    %-12s\n" "''${name}" "''${m}" "-" "ERR:''${code}"
        snippet=$(printf "%s" "''${body}" | tr '\n' ' ' | tr '\r' ' ' | sed 's/[[:space:]]\+/ /g' | cut -c1-300)
        [[ -z "''${snippet}" ]] && snippet="<empty>"
        printf "%s\t%s\t%s\t%s\n" "''${name}" "''${m}" "ERR:''${code}" "''${snippet}" >> "''${tmp_fails}"
      fi
    }

    max_parallel=4
    pids=()

    while IFS= read -r p; do
      [[ -z "''${p}" ]] && continue

      name=$(echo "''${p}" | jq -r '.name // empty')
      base=$(echo "''${p}" | jq -r '.api_base_url // empty' | xargs)
      key=$(echo "''${p}" | jq -r '.api_key // empty')
      unsupported=$(echo "''${p}" | jq -r 'if .transformer? != null then 1 else 0 end')

      [[ -z "''${name}" ]] && continue
      [[ "''${key}" == "null" ]] && continue
      [[ "''${key}" == "sk-xxx" ]] && continue
      [[ -z "''${key}" ]] && continue

      while IFS= read -r m; do
        [[ -z "''${m}" ]] && continue

        run_check "''${name}" "''${m}" "''${base}" "''${key}" "''${unsupported}" &
        pids+=("$!")

        if (( ''${#pids[@]} >= max_parallel )); then
          wait "''${pids[0]}" || true
          pids=("''${pids[@]:1}")
        fi
      done < <(echo "''${p}" | jq -r '.models[]?' 2>/dev/null)
    done < <(echo "''${JSON_CLEAN}" | jq -c '.Providers[]' 2>/dev/null)

    for pid in "''${pids[@]}"; do
      wait "''${pid}" || true
    done

    if [[ -s "''${tmp_fails}" ]]; then
      echo
      printf '%0.s-' {1..82}
      echo
      echo "Failure log:"
      while IFS=$'\t' read -r name m status detail; do
        printf -- "- [%s / %s] %s\n" "''${name}" "''${m}" "''${status}"
        printf -- "detail: %s\n\n" "''${detail}"
      done < "''${tmp_fails}"
    fi

  '';
}
