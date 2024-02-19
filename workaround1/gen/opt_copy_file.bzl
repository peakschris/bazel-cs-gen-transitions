load("@aspect_bazel_lib//lib:copy_file.bzl", "copy_file")
load("@with_cfg.bzl", "with_cfg")

# copy_file rule that always uses opt configuration
opt_copy_file, _opt_copy_file_internal = with_cfg(copy_file).set("cfg", "target").build()

_builder = with_cfg(copy_file)
_builder.resettable(Label(":copy_file_original_settings"))
_builder.reset_on_attrs("data", "srcs")
opt_copy_file, opt_copy_file_reset = _builder.build()

