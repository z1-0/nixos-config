let
  nameValuePair = name: value: { inherit name value; };
  genAttrs' = xs: f: builtins.listToAttrs (map f xs);
  genAttrs = names: f: genAttrs' names (n: nameValuePair n (f n));
in
genAttrs
  [
    "mihomo.yaml.age"
    "github-token.age"
    "nix-access-tokens.age"
    "context7-api-key.age"
    "gemini-api-key.age"
    "tavily-api-key.age"
  ]
  (_: {
    publicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZ3GH+khQ20uYa9IVq2MnXeZP5W1P1WWXVcKEoOHPaE"
    ];
  })
