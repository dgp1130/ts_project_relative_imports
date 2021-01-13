# `ts_project()` `exec` configuration cannot resolve local imports

To reproduce:

```
$ npm install

$ bazel build //:foo
# works

$ bazel run //:binary
# works

$ bazel build //:rule
INFO: Invocation ID: 0d84bd09-9d57-4f56-b32b-c9e02f9c7d9d
INFO: Analyzed target //:rule (0 packages loaded, 13 targets configured).
INFO: Found 1 target...
ERROR: /home/dparker/Source/ts_project/BUILD.bazel:23:11: Compiling TypeScript project //:foo [tsc -p tsconfig.json] failed (Exit 2) tsc.sh failed: error executing command bazel-out/k8-opt-exec-2B5CBBC6/bin/external/npm/typescript/bin/tsc.sh --project tsconfig.json --outDir bazel-out/k8-opt-exec-2B5CBBC6/bin --rootDir . --declarationDir bazel-out/k8-opt-exec-2B5CBBC6/bin ... (remaining 1 argument(s) skipped)

Use --sandbox_debug to see verbose messages from the sandbox
foo.ts(2,21): error TS2307: Cannot find module './baz' or its corresponding type declarations.
Target //:rule failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 1.045s, Critical Path: 0.80s
INFO: 2 processes: 2 internal.
FAILED: Build did NOT complete successfully

$ bazel build //:bin
INFO: Invocation ID: a4cc94d5-3d0a-45af-b804-89699c7007a1
INFO: Analyzed target //:bin (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
ERROR: /home/dparker/Source/ts_project/BUILD.bazel:23:11: Compiling TypeScript project //:foo [tsc -p tsconfig.json] failed (Exit 2) tsc.sh failed: error executing command bazel-out/host/bin/external/npm/typescript/bin/tsc.sh --project tsconfig.json --outDir bazel-out/host/bin --rootDir . --declarationDir bazel-out/host/bin ... (remaining 1 argument(s) skipped)

Use --sandbox_debug to see verbose messages from the sandbox
foo.ts(2,21): error TS2307: Cannot find module './baz' or its corresponding type declarations.
Target //:bin failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 0.917s, Critical Path: 0.74s
INFO: 2 processes: 2 internal.
FAILED: Build did NOT complete successfully
```
