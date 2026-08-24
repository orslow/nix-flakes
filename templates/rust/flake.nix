{
  description = "Rust dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, rust-overlay, ... }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      forEachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          })
        );
    in
    {
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = [
            # rust-toolchain.toml 을 그대로 읽음
            # -> rustup 쓰는 팀원과 같은 파일 공유 가능, 버전은 flake.lock 으로 고정
            (pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)

            pkgs.pkg-config
            pkgs.cargo-nextest
          ];

          # darwin 에서 링크 에러 단골 조합
          buildInputs = [
            pkgs.openssl
            pkgs.libiconv
          ];

          env.RUST_BACKTRACE = "1";
        };
      });
    };
}
