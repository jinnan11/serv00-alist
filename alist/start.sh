SCRIPT_PATH=$(realpath "$0")
WORKDIR=$(dirname "${SCRIPT_PATH}")
cd "${WORKDIR}"
FILES_PATH=${FILES_PATH:-./}
CURRENT_VERSION=''
RELEASE_LATEST=''
CMD="$@"
get_current_version() {
    chmod +x ./web.js 2>/dev/null
    CURRENT_VERSION=$(./web.js version | grep -o v[0-9]*\.*.)
}
get_latest_version() {
    # Get latest release version number
    RELEASE_LATEST="$(curl -IkLs -o ${TMP_DIRECTORY}/NUL -w %{url_effective} https://github.com/AlistGo/alist/releases/latest | grep -o "[^/]*$")"
    RELEASE_LATEST="v${RELEASE_LATEST#v}"
    if [[ -z "$RELEASE_LATEST" ]]; then
        echo "error: Failed to get the latest release version, please check your network."
        exit 1
    fi
}
download_web() {
    DOWNLOAD_LINK="https://github.com/AlistGo/alist/releases/latest/download/alist-freebsd-amd64.tar.gz"
    if ! wget -qO "$ZIP_FILE" "$DOWNLOAD_LINK"; then
        echo 'error: Download failed! Please check your network or try again.'
        return 1
    fi
    return 0
}
install_web() {
    tar -xzf "$ZIP_FILE" -C "$TMP_DIRECTORY"
    install -m 755 ${TMP_DIRECTORY}/alist ${FILES_PATH}/web.js
}
run_web() {
    nohup killall web.js > /dev/null
    chmod +x ./web.js
    exec ./web.js server > /dev/null 2>&1 &
}
TMP_DIRECTORY="$(mktemp -d)"
ZIP_FILE="${TMP_DIRECTORY}/alist-freebsd-amd64.tar.gz"
get_current_version
get_latest_version
if [ "${RELEASE_LATEST}" = "${CURRENT_VERSION}" ]; then
    "rm" -rf "$TMP_DIRECTORY"
    run_web
    exit
fi
download_web
EXIT_CODE=$?
if [ ${EXIT_CODE} -eq 0 ]; then
    :
else
    "rm" -rf "$TMP_DIRECTORY"
    run_web
    exit
fi
install_web
"rm" -rf "$TMP_DIRECTORY"
run_web
