#!/usr/bin/env bash

set -euo pipefail

readonly script_directory="$(cd "${BASH_SOURCE[0]%/*}" && pwd)"
readonly source_directory="${script_directory}/riscv-gnu-toolchain"
readonly build_directory="${source_directory}/build-rv32i"
readonly install_directory="${source_directory}/install"

if [[ ! -x "${source_directory}/configure" ]]; then
    echo "Missing toolchain source: ${source_directory}" >&2
    echo "Clone riscv-collab/riscv-gnu-toolchain before running this script." >&2
    exit 1
fi

required_commands=(
    autoconf
    automake
    awk
    bison
    cmake
    curl
    flex
    g++
    gcc
    gperf
    make
    makeinfo
    ninja
    patch
    python3
)

missing_commands=()
for command_name in "${required_commands[@]}"; do
    if ! command -v "${command_name}" >/dev/null 2>&1; then
        missing_commands+=("${command_name}")
    fi
done

if (( ${#missing_commands[@]} != 0 )); then
    echo "Missing build commands: ${missing_commands[*]}" >&2
    echo "On Ubuntu/WSL Ubuntu, install the prerequisites documented by" >&2
    echo "riscv-collab/riscv-gnu-toolchain before retrying." >&2
    exit 1
fi

build_jobs="${JOBS:-}"
if [[ -z "${build_jobs}" ]]; then
    if command -v nproc >/dev/null 2>&1; then
        build_jobs="$(nproc)"
    else
        build_jobs="1"
    fi
fi

mkdir -p "${build_directory}"
mkdir -p "${install_directory}"

cd "${build_directory}"

"${source_directory}/configure" \
    --prefix="${install_directory}" \
    --with-arch=rv32i \
    --with-abi=ilp32 \
    --with-languages=c \
    --disable-gdb

make -j"${build_jobs}"

"${install_directory}/bin/riscv64-unknown-elf-gcc" --version
"${install_directory}/bin/riscv64-unknown-elf-gcc" \
    -march=rv32i \
    -mabi=ilp32 \
    --print-multi-lib

echo "RV32I toolchain installed in: ${install_directory}/bin"
