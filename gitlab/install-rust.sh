source ./gitlab/env.sh

RUSTUP_VERSION=1.23.1
RUST_VERSION=$1
RUST_ARCH="x86_64-unknown-linux-gnu"

RUSTUP_URL=https://static.rust-lang.org/rustup/archive/$RUSTUP_VERSION/$RUST_ARCH/rustup-init
wget $RUSTUP_URL

chmod +x rustup-init;
./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION;
rm rustup-init;
chmod -R a+w $RUSTUP_HOME $CARGO_HOME

rustup --version
cargo --version
rustc --version

rustup component add clippy-preview
rustup component add rustfmt
cargo install --force cargo-audit
cargo install --force grcov

# nightly, used to generate tests coverage
rustup install nightly
rustup component add llvm-tools-preview

# fetch project deps
cargo fetch