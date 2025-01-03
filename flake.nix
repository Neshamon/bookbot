{
  description = "A Nix-flake-based Bookbot development environment";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
  };

  outputs = { self, nixpkgs }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          venvDir = ".venv";
          packages = with pkgs; [ python313 go gotools ] ++
            (with pkgs.python313Packages; [
              pip
              venvShellHook
            ]);

          shellHook = ''export GOBIN=$HOME/.local/share/go/bin
                        export GOPATH=$HOME/.local/share/go/bin
                        export PATH=$PATH:$HOME/.local/share/go/bin
                        go telemetry off
                        go install github.com/bootdotdev/bootdev@latest'';
        };
      });
    };
}
