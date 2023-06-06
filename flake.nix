# this flakes uses godot-flake to build GodotRandomMapScripts
{
  description = "gdrms to enable RandomScriptMaps in Godot";
  inputs = {
    # the godot Engine
    godot-flake = {
      url = "github:MadMcCrow/godot-flake";
    };
  };

  # func
  outputs = { self, nixpkgs, ... }@inputs:
    let
      # only linux supported, todo, support darwin
      system = "x86_64-linux";
      # use nixpkgs
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;
      # get function from other flake
      libGDExt = inputs.godot-flake.lib.libGDExt;
      libGodot = inputs.godot-flake.lib.libGodot;

      # godot editor for demo testing
      godot-editor = libGodot.mkGodot {withTemplates = false;};

      # implementation
      gdrms = libGDExt.mkGDExt { 
          extName = "gdosc";
          src = self;
          installPhase = ''
            mkdir -p $out/bin
            cp bin/gdrms*.so $out/bin/gdrms.so
            cp gdrms.gdextension $out/gdrms.gdextension
            '';
        };

      in {
      #interface
      packages."${system}" = with pkgs; {
        inherit gdrms;
      };
      # dev-shell
      devShells."${system}".default = (libGDExt.mkExtensionShell gdosc).overrideAttrs (oldAttr:
      {
         inputsFrom = [gdrms];
         shellHook = oldAttr.shellHook + ''
            ln -s ${godot-editor}/bin/*
            mkdir -p demo/godot/bin/x11
            ln -s  ../../../gdrms.gdextension demo/godot/bin/gdrms.gdextension 
         '';
      });
    };
}