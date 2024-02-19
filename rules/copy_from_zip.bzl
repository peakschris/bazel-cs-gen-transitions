def _copy_from_zip_impl(ctx):
    relative_dir = ctx.file.out.path.removeprefix(ctx.label.package+"/")
    dst = ctx.actions.declare_directory(relative_dir)
    dst_path = ctx.var['GENDIR']+"/"+ctx.file.out.path
    extract_dir = ctx.var['GENDIR']+"/"+ctx.file.out.path
    mv_command = ""
    clean_command = ""
    if (ctx.attr.include_srcs):
        if (relative_dir != ctx.attr.include_srcs):
            extract_dir = dst_path+"_tmp"
            mv_command = " && mv "+extract_dir+"/"+ctx.attr.include_srcs+"/* "+dst_path+" && rm -rf "+extract_dir
            clean_command += "rm -rf "+extract_dir+" && "
        else:
            extract_dir = ctx.var['GENDIR']+"/"+ctx.label.package
    unzip_cmd = "unzip -q "+ctx.file.zip.path
    message = "Extracting from "+ctx.file.zip.basename+" to "+ctx.file.out.path+"..."
    if (ctx.attr.include_srcs != ""):
        if (not ctx.attr.exclude_subdirs):
            unzip_cmd += " \""+ctx.attr.include_srcs+"/**/*\""
            message = "Extracting "+ctx.attr.include_srcs+"/**/* from "+ctx.file.zip.basename+" to "+ctx.file.out.path+"..."
        else:
            message = "Extracting "+ctx.attr.include_srcs+"/* from "+ctx.file.zip.basename+" to "+ctx.file.out.path+"..."
        unzip_cmd += " \""+ctx.attr.include_srcs+"/*\""
    unzip_cmd += " -d "+extract_dir
    command = unzip_cmd
    if (mv_command or clean_command):
        command = clean_command + "("+unzip_cmd+" || true)" + mv_command
    #print(command)
    ctx.actions.run_shell(
        inputs = [ctx.file.zip],
        outputs = [dst],
        command = command,
        progress_message = message,
        mnemonic = "unzip",
    )

    return [
        DefaultInfo(
            files = depset([dst]),
            runfiles = ctx.runfiles([dst]),
        ),
    ]

copy_from_zip = rule(
    implementation = _copy_from_zip_impl,
    attrs = {
        "zip": attr.label(allow_single_file=True),
        "include_srcs": attr.string(),
        "out": attr.label(allow_single_file=True),
        "exclude_subdirs": attr.bool(default=False),
    },
)
