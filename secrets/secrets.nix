let
  jueon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFloeOjKfZVSYBShxxeOviv/LPoL3IEsQmJFq8mnukJS";
in
{
  "secret1.age".publicKeys = [ jueon ];
}
