### Workaround1

Use rules_dotnet's default_transition in the copy_file rule. This resets to default dotnet transition,
but doesn't reset all transitions, and also leaves all the code generation rule running in a directory
with hash suffix, rather than the actual default.
