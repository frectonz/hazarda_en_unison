{
  description = "A flake for a random number game in unison";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    unison = {
      url = "github:ceedubs/unison-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };
  };

  outputs = { self, nixpkgs, utils, unison }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ unison.overlay ];
      };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ unison-ucm ];
      };

      formatter = pkgs.nixpkgs-fmt;
    }
  );

}
