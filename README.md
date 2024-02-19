### This repo demonstrates the issue with rules_dotnet and transitions

Two rules, csharp_binary and cc_binary both depend on a single code generation rule.
However, because csharp_binary uses transitions, the code generation rule runs multiple times,
once for cc_binary, and another time for each csharp_binary target framework.

### Demonstrating the issue
```
bazel clean
bazel build //problem/cs //problem/cpp
```
Note that gen.zip appears in two separate subdirectories in bazel-out

### Demonstrating a poor workaround
```
bazel clean
bazel build //workaround1/cs //workaround/cpp
```
Note that gen.zip appears in just one subdirectory in bazel-out, but not in the actual default 'windows-fastbuild' subdirectory.

### Desired solution
- rules_dotnet should reset srcs and dependencies that are not other rules_dotnet targets back to actual default
- or: a way to reset a custom codegen rule back to actual default transition
- or: a way to reset an ootb rule back to actual default transition

