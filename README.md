# `ts_project()` `exec` / `host` configuration cannot absolute require

To reproduce:

```
$ npm install

$ bazel build //:foo
INFO: Invocation ID: 04e6b0de-7aab-4d2e-89d3-c3be24dd58a8
INFO: Analyzed target //:foo (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //:foo up-to-date:
  dist/bin/foo.js
INFO: Elapsed time: 0.144s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action

$ bazel run //:binary
INFO: Invocation ID: ff7802fb-02e4-4df1-91a0-2c90538cbe06
INFO: Analyzed target //:binary (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //:binary up-to-date:
  dist/bin/binary.sh
  dist/bin/binary_loader.js
  dist/bin/binary_require_patch.js
INFO: Elapsed time: 0.149s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
INFO: Build completed successfully, 1 total action
bar
baz
dirFile

$ bazel build //:rule
INFO: Invocation ID: cd660524-a61e-4c8e-80d3-96ad1a94862e
INFO: Analyzed target //:rule (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
ERROR: /home/dparker/Source/ts_project/BUILD.bazel:7:8: Action output.txt failed (Exit 1) binary.sh failed: error executing command bazel-out/host/bin/binary.sh '--bazel_node_modules_manifest=bazel-out/k8-fastbuild/bin/_rule.module_mappings.json'

Use --sandbox_debug to see verbose messages from the sandbox
internal/modules/cjs/loader.js:797
    throw err;
    ^

Error: Cannot find module 'ts_project/baz'
Require stack:
- /home/dparker/.cache/bazel/_bazel_dparker/6658967657985275154ca8132b22af68/sandbox/linux-sandbox/96/execroot/ts_project/bazel-out/host/bin/binary.sh.runfiles/ts_project/foo.js
    at Function.Module._resolveFilename (internal/modules/cjs/loader.js:794:15)
    at Function.Module._load (internal/modules/cjs/loader.js:687:27)
    at Module.require (internal/modules/cjs/loader.js:849:19)
    at require (internal/modules/cjs/helpers.js:74:18)
    at Object.<anonymous> (/home/dparker/.cache/bazel/_bazel_dparker/6658967657985275154ca8132b22af68/sandbox/linux-sandbox/96/execroot/ts_project/bazel-out/host/bin/binary.sh.runfiles/ts_project/foo.js:4:13)
    at Module._compile (internal/modules/cjs/loader.js:956:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:973:10)
    at Module.load (internal/modules/cjs/loader.js:812:32)
    at Function.Module._load (internal/modules/cjs/loader.js:724:14)
    at Function.Module.runMain (internal/modules/cjs/loader.js:1025:10) {
  code: 'MODULE_NOT_FOUND',
  requireStack: [
    '/home/dparker/.cache/bazel/_bazel_dparker/6658967657985275154ca8132b22af68/sandbox/linux-sandbox/96/execroot/ts_project/bazel-out/host/bin/binary.sh.runfiles/ts_project/foo.js'
  ]
}
Target //:rule failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 0.224s, Critical Path: 0.09s
INFO: 2 processes: 2 internal.
FAILED: Build did NOT complete successfully

$ bazel build //:bin
INFO: Invocation ID: 3c08db44-dc64-4e3a-a037-c951ef5c6c1d
INFO: Analyzed target //:bin (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
ERROR: /home/dparker/Source/ts_project/BUILD.bazel:12:16: Action bin_output.txt failed (Exit 1) binary.sh failed: error executing command bazel-out/host/bin/binary.sh '--bazel_node_modules_manifest=bazel-out/k8-fastbuild/bin/_bin.module_mappings.json'

Use --sandbox_debug to see verbose messages from the sandbox
internal/modules/cjs/loader.js:797
    throw err;
    ^

Error: Cannot find module 'ts_project/baz'
Require stack:
- /home/dparker/.cache/bazel/_bazel_dparker/6658967657985275154ca8132b22af68/sandbox/linux-sandbox/97/execroot/ts_project/bazel-out/host/bin/binary.sh.runfiles/ts_project/foo.js
    at Function.Module._resolveFilename (internal/modules/cjs/loader.js:794:15)
    at Function.Module._load (internal/modules/cjs/loader.js:687:27)
    at Module.require (internal/modules/cjs/loader.js:849:19)
    at require (internal/modules/cjs/helpers.js:74:18)
    at Object.<anonymous> (/home/dparker/.cache/bazel/_bazel_dparker/6658967657985275154ca8132b22af68/sandbox/linux-sandbox/97/execroot/ts_project/bazel-out/host/bin/binary.sh.runfiles/ts_project/foo.js:4:13)
    at Module._compile (internal/modules/cjs/loader.js:956:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:973:10)
    at Module.load (internal/modules/cjs/loader.js:812:32)
    at Function.Module._load (internal/modules/cjs/loader.js:724:14)
    at Function.Module.runMain (internal/modules/cjs/loader.js:1025:10) {
  code: 'MODULE_NOT_FOUND',
  requireStack: [
    '/home/dparker/.cache/bazel/_bazel_dparker/6658967657985275154ca8132b22af68/sandbox/linux-sandbox/97/execroot/ts_project/bazel-out/host/bin/binary.sh.runfiles/ts_project/foo.js'
  ]
}
Target //:bin failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 0.243s, Critical Path: 0.09s
INFO: 2 processes: 2 internal.
FAILED: Build did NOT complete successfully
```
