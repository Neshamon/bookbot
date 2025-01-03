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
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          venvDir = ".venv";
          packages = with pkgs; [ python311 go gotools ] ++
            (with pkgs.python311Packages; [
              pip
              venvShellHook
            ]);

          shellHook = ''export GOBIN=$HOME/Projects/.go/bin
                        export GOPATH=$HOME/Projects/bookbot/.go/bin
                        export PATH=$PATH/:$HOME/Projects/bookbot/.go/bin'';
        };
      });
    };
}
