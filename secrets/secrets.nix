let
  jueon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFloeOjKfZVSYBShxxeOviv/LPoL3IEsQmJFq8mnukJS";
in
{
  # "anthropic_api_key.age".publicKeys = [ jueon ];
  "github_token.age".publicKeys = [ jueon ];
}
