self: super: {
  libpkcs11-dnie = super.callPackage (super.fetchFromGitHub {
    owner = "alexland7219";
    repo = "libpkcs11-dnie-nix";
    rev = "v1.6.8-1";
    sha256 = "sha256-AwyyC5EOYbte+/rpRzZTyTS2VSGA5GKdKNa2vQhoFIc=";
  } + "/package.nix") {};
}
