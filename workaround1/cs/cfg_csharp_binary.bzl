load("@rules_dotnet//dotnet:defs.bzl", "csharp_binary")
load("@with_cfg.bzl", "with_cfg")


_builder = with_cfg(csharp_binary)
_builder.resettable(Label(":csharp_binary_original_settings"))
_builder.reset_on_attrs("cfg")
opt_copy_file, opt_copy_file_reset = _builder.build()

