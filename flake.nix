{
  description = "A Nix-flake-based Bookbot development environment";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
    bootdev = {
      url = "github:bootdotdev/bootdev";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, bootdev }@inputs:
    let
      project = "bookbot";
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          venvDir = ".venv";
          packages = with pkgs; [ python314 go gotools ] ++
            (with pkgs.python311Packages; [
              pip
              venvShellHook
            ]);

          shellHook = ''export GOBIN=$HOME/Projects/${project}/.go/bin
                        export GOPATH=$HOME/Projects/${project}/.go/bin
                        export PATH=$PATH:$HOME/Projects/${project}/.go/bin
                        go telemetry off'';
        };
      });
    };
}
